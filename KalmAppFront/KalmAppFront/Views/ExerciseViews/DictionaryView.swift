import SwiftUI

struct DictionaryView: View, ExerciseModel {
    @State internal var countOfQuestions: Int = 10
    @State internal var name: String = "Dictionary"
    @State internal var userID: String
    @State internal var categoryID: String
    @State internal var progress: CGFloat = 0.0
    @State internal var currentIndex: Int = 0
    @State internal var score: Int = 0
    @State internal var showScoreCard: Bool = false
    @State private var index = 0
    
    var words: [Word]
    @State internal var question: Question
    @State var viewState: CGFloat = 0
    let spacing: CGFloat = 10
    
    init(words: [Word], userID: String, categoryID: String) {
        self.words = words
        self.words.shuffle()
        _question = State(initialValue: makeQuestion(self.words, 2))
        self._userID = State(initialValue: userID)
        self._categoryID = State(initialValue: categoryID)
    }
    
    /// - View Properties
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            Color("BgColor").edgesIgnoringSafeArea(.all)
            VStack(spacing: 15) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("PrimaryColor"))
                }
                .hAllign(.leading)
                
                /// - Progress Bar
                GeometryReader {
                    let size = $0.size
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(.black.opacity(0.2))
                        Rectangle()
                            .fill(Color("PrimaryColor"))
                            .frame(width: progress*size.width, alignment: .leading)
                    }
                    .clipShape(Capsule())
                }
                .frame(height: 20)
                .padding(.top, 5)
                
                /// Questions
                GeometryReader { geometry in
                    ScrollView(.vertical) {
                        VStack {
                            ForEach(0..<countOfQuestions, id:\.self) { index in
                                if currentIndex == index {
                                    SwiperView()
                                        .frame(height: geometry.size.height - 10)
                                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                                        .padding([.leading, .trailing], 10)
                                }
                            }
                        }
                    }
                }
            }
            .padding(15)
            .hAllign(.center)
        }
    }
}
