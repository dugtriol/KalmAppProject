//
//  DictionaryView.swift
//  KalmAppFront
//
//  Created by Айгуль Манджиева on 20.09.2023.
//

import SwiftUI

struct DictionaryView: View {
    var words: [Word]
    @State var name: String = "Dictionary"
    @State var question: Question
    @State private var progress: CGFloat = 0.0
    @State private var currentIndex: Int = 0
    @State private var score: Int = 0
    private let countOfQuestions: Int = 10
    @State var viewState: CGFloat = 0
    @State private var index = 0
    let spacing: CGFloat = 10
    @State private var showScoreCard: Bool = false
    
    init(words: [Word]) {
        self.words = words
        self.words.shuffle()
        _question = State(initialValue: makeQuestion(self.words, 2))
    }
    
    /// - View Properties
    @Environment(\.dismiss) private var dismiss
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
                            ForEach(0..<countOfQuestions) { index in
                                
                                if currentIndex == index {
                                    SwipeView()
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
    
    
    @ViewBuilder
    func SwipeView() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack {
                ForEach(self.question.options, id: \.self) { option in
                    ZStack {
                        WordView(option.kalmyk, Color("PrimaryColor"))
                            .opacity(question.question.id == option.id && question.tappedAnswer != "" && question.tappedAnswer == option.id ? 0 : 1)
                        WordView(option.kalmyk, .green)
                            .opacity(question.tappedAnswer != "" && question.tappedAnswer == option.id && question.tappedAnswer == question.question.id ? 1 : 0)
                        WordView(option.kalmyk, .red)
                            .opacity(question.tappedAnswer != "" && question.tappedAnswer == option.id  && question.tappedAnswer != question.question.id ? 1 : 0)
                    }
                    .offset(y: self.viewState)
                    .roundedCorner(20, corners: question.options[0].id == option.id ? [.topLeft, .topRight] : [.bottomLeft, .bottomRight])
                    .gesture(
                        DragGesture(minimumDistance: 10, coordinateSpace: .global)
                            .onChanged({ value in
                                if value.translation.height < 0 {
                                    /// - Swipe up
                                    /// Disabling Tap if Already Answer was selected
                                    guard question.tappedAnswer == "" else {return}
                                    self.question.tappedAnswer = question.options[0].id
                                    if question.question.id == self.question.tappedAnswer {
                                        score += 1
                                    }
                                }
                                if value.translation.height > 0 {
                                    /// Disabling Tap if Already Answer was selected
                                    guard question.tappedAnswer == "" else {return}
                                    self.question.tappedAnswer = question.options[1].id
                                    if self.question.question.id == self.question.tappedAnswer {
                                        score += 1
                                    }
                                }
                                /// - Swipe down
                            })
                            .onEnded({ value in
                                if currentIndex == (countOfQuestions - 1) {
                                    /// - Presenting Score Card View
                                    showScoreCard.toggle()
                                } else{
                                    withAnimation(.easeOut) {
                                        viewState = .zero
                                        currentIndex += 1
                                        self.question = makeQuestion(self.words, 2)
                                        progress = CGFloat(currentIndex) / CGFloat(countOfQuestions - 1)
                                    }
                                }
                            })
                    )
                }
            }
            .overlay {
                Text(question.question.russian)
                    .padding([.top, .bottom], 10)
                    .padding([.leading, .trailing], 60)
                    .background{
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color("PrimaryColor"))
                    }
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
        }
        .font(.title3)
        .hAllign(.center)
        .background{
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color("PrimaryColor")).opacity(0.3)
        }
        .fullScreenCover(isPresented: $showScoreCard) {
            /// - Displaying in 100%
            ScoreCardView(score: score, countOfQuestions: countOfQuestions) {
                /// - Closing View
                dismiss()
            }
        }
    }
    
    @ViewBuilder
    func WordView(_ option: String, _ tint: Color) -> some View {
        Text(option)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .font(.system(size: 20))
            .hAllign(.center)
            .vAllign(.center)
            .background(tint == Color("PrimaryColor") ? tint.opacity(0.1) : tint.opacity(0.75))
    }
}
struct DictionaryView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
