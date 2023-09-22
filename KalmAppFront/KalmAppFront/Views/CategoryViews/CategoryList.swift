import SwiftUI
import Foundation

struct CategoryList: View {
    @EnvironmentObject private var modelData: ModelData
    @State var index = 0
    @State var offsets = [CGFloat](repeating: 0, count: 2)
    @State var scrolled = 0
    @Binding var user: User?
    
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            Color("BgColor").edgesIgnoringSafeArea(.all)
            NavigationStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        HStack {
                            Text("Добро пожаловать,\n\(user!.name)!")
                                .padding()
                                .font(.caption)
                                .foregroundColor(Color("TitleTextColor").opacity(0.6))
                                .hAllign(.leading)
                        }
                        Spacer()
                        HStack {
                            Text("Категории")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(Color("TitleTextColor"))
                            Spacer(minLength: 0)
                        }
                        .padding(.bottom)
                        .padding(.horizontal)
                        
                        ///  - Card View
                        ZStack {
                            ForEach (modelData.categories.reversed().indices, id: \.self) { index in
                                HStack {
                                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                                        Image(modelData.categories[getId(index)].image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: calculateWidth(), height: (UIScreen.main.bounds.height / 1.8) - CGFloat(getId(index) - scrolled) * 50)
                                            .cornerRadius(15)
                                        VStack (alignment: .leading, spacing: 18) {
                                            VStack(alignment: .leading) {
                                                Text(modelData.categories[getId(index)].titleKalmyk)
                                                    .font(.title)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.white)
                                                Text(modelData.categories[getId(index)].titleRussian)
                                                    .font(.title)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.white)
                                            }
                                            NavigationLink (value: modelData.categories[getId(index)]) {
                                                Text("Начать")
                                                    .font(.subheadline)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.white)
                                                    .padding(.vertical, 10)
                                                    .padding(.horizontal, 25)
                                                    .background(Color("PrimaryColor"))
                                                    .clipShape(Capsule())
                                            }
                                        }
                                        .frame(width: calculateWidth() - 40)
                                        .padding(.bottom, 20)
                                    }
                                    .offset(x: (getId(index) - scrolled <= 2 ? CGFloat((getId(index) - scrolled) * 30) : 60))
                                    Spacer(minLength: 0)
                                }
                                .contentShape(Rectangle())
                                .offset(x: offsets[getId(index)])
                                .gesture(
                                    DragGesture()
                                        .onChanged({ (value) in
                                            withAnimation {
                                                /// -  Disabling drag for last card
                                                if value.translation.width < 0 && getId(index) != modelData.categories.count - 1 {
                                                    offsets[getId(index)] = value.translation.width
                                                } else {
                                                    if getId(index) > 0 {
                                                        offsets[getId(index) - 1] = -(calculateWidth() + 60) + value.translation.width
                                                    }
                                                }
                                            }
                                        })
                                        .onEnded({ (value) in
                                            withAnimation {
                                                if value.translation.width < 0 {
                                                    if -value.translation.width > 180 && getId(index) != modelData.categories.count - 1  {
                                                        /// -  Moving view away
                                                        offsets[getId(index)] = -(calculateWidth() + 60)
                                                        scrolled += 1
                                                    }
                                                    else {
                                                        offsets[getId(index)] = 0
                                                    }
                                                } else {
                                                    /// - Restoring card
                                                    if getId(index) > 0 {
                                                        if value.translation.width > 180 {
                                                            offsets[getId(index) - 1] = 0
                                                            scrolled -= 1
                                                        } else {
                                                            offsets[getId(index) - 1] = -(calculateWidth() + 60)
                                                        }
                                                    }
                                                }
                                            }
                                        })
                                )
                            }
                        }
                        .navigationDestination(for: Category.self, destination: { category in
                            CategoryView(category: category, userId: user!.id)
                        })
                        .frame(height: UIScreen.main.bounds.height / 1.8)
                        .padding(.top, 25)
                        .padding(.horizontal, 25)
                    }
                }
                Button {
                    dismiss()
                } label: {
                    Text("Выйти")
                }
            }
            .navigationTitle("Категории")
            .accentColor(Color("PrimaryColor"))
            .task {
                do {
                    try await modelData.fetchCategories()
                    offsets = [CGFloat](repeating: 0, count: modelData.categories.count)
                } catch {
                    print("error CategoryList")
                }
            }
        }
    }
    
    func calculateWidth() -> CGFloat {
        /// - Horizonatal padding 30
        let screen = UIScreen.main.bounds.width - 30
        
        /// -  Going to show first three cards
        /// - All other will be removed
        
        /// - Second and third will be removed x axis with 30 value
        let width = screen - (2 * 30)
        return width
    }
    
    func getId(_ index: Int) -> Int {
        return modelData.categories.count - index - 1
    }
}
