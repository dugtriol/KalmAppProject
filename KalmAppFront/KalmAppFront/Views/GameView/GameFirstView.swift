//
//  GameFirstView.swift
//  KalmAppFront
//
//  Created by Айгуль Манджиева on 18.09.2023.
//

import SwiftUI

struct GameFirstView: View {
    @State private var progress: CGFloat = 0.0
    @State private var currentIndex: Int = 0
    @State private var score: CGFloat = 0
    private let countOfQuestions: Int = 10
    @State private var showScoreCard: Bool = false
    @State private var questionText: String = ""
    @State private var optionText: String = ""
    @State private var method: Int = 0
    
    var words: [Word]
    @State var question: Question
    
    init(words: [Word]) {
        self.words = words
        self.words.shuffle()
        _question = State(initialValue: makeQuestion(self.words, 4))
    }
    
    /// - View Properties
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(spacing: 15) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .hAllign(.leading)
            
            /// - Progress Bar
            GeometryReader {
                let size = $0.size
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(.black.opacity(0.2))
                    Rectangle()
                        .fill(Color(.blue))
                        .frame(width: progress*size.width, alignment: .leading)
                }
                .clipShape(Capsule())
            }
            .frame(height: 20)
            .padding(.top, 5)
            
            /// Questions
            GeometryReader { _ in
                ForEach(0..<countOfQuestions) { index in
                    if currentIndex == index {
                        QuestionView(question, method)
                    }
                }
            }
            
            .padding(.horizontal, -15)
            .padding(.vertical, 15)
            
            /// - Changing Button to Finish When the Last Question Arrived
            SelectButton(title: currentIndex == (countOfQuestions - 1) ? "Finish" : "Next Question", onClick: {
                if currentIndex == (countOfQuestions - 1) {
                    /// - Presenting Score Card View
                    showScoreCard.toggle()
                } else {
                    withAnimation(.default) {
                        self.question = makeQuestion(self.words, 4)
                        currentIndex += 1
                        progress = CGFloat(currentIndex) / CGFloat(countOfQuestions - 1)
                    }
                }
                method = currentIndex % 3
            })
            .disabled(question.tappedAnswer == "")
        }
        .padding(15)
        .hAllign(.center).vAllign(.top)
        .background {
            Color(.gray)
                .ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $showScoreCard) {
            /// - Displaying in 100%
            ScoreCardView(score: score / CGFloat(countOfQuestions) * 100) {
                /// - Closing View
                dismiss()
            }
        }
    }
    
    
    @ViewBuilder
    func QuestionView(_ question: Question, _ method: Int) -> some View{
        VStack(alignment: .leading, spacing: 15) {
            Text("Question \(currentIndex + 1)/\(countOfQuestions)")
                .font(.callout)
                .foregroundColor(.black)
                .hAllign(.leading)
            Text(method == 0 ? question.question.russian : question.question.kalmyk)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.black)
            VStack(spacing: 12) {
                ForEach(question.options, id: \.self) { option in
                    /// Displaying Correct and Wrong answers  after user has tapped any one of the options
                    ZStack {
                        OptionView(option, .gray, method == 0 ? 0 : method == 1 ? 1 : 2)
                            .opacity(question.question.id == option.id && question.tappedAnswer != "" ? 0 : 1)
                        OptionView(option, .green, method == 0 ? 0 : method == 1 ? 1 : 2)
                            .opacity(question.question.id == option.id && question.tappedAnswer != "" ? 1 : 0)
                        OptionView(option, .red, method == 0 ? 0 : method == 1 ? 1 : 2)
                            .opacity(question.tappedAnswer == option.id && question.tappedAnswer != question.question.id ? 1 : 0)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        /// Disabling Tap if Already Answer was selected
                        guard question.tappedAnswer == "" else {return}
                        self.question.tappedAnswer = option.id
                        if self.question.question.id == self.question.tappedAnswer {
                            score += 1.0
                        }
                    }
                }
            }
            .padding(.vertical, 10)
        }
        .padding(15)
        .hAllign(.center)
        .background{
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.white)
        }
        .padding(.horizontal, 15)
    }
    
    @ViewBuilder
    func OptionView(_ option: Word, _ tint: Color, _ method: Int) -> some View {
        if method == 2 {
            AsyncImage(url: URL(string: option.image), scale: 20)
            //.resizable()
                .frame(width: 100, height: 100)
                .aspectRatio(contentMode: .fill)
                .clipShape(Rectangle())
                .hAllign(.center)
                .background{
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(tint.opacity(0.15))
                        .background{
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(tint.opacity(tint == .gray ? 0.15 : 1), lineWidth: 2)
                        }
                }
        }
            else {
            Text(method == 0 ? option.kalmyk : option.russian)
                .foregroundColor(tint)
                .padding(.horizontal, 15)
                .padding(.vertical, 20)
                .hAllign(.leading)
                .background {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(tint.opacity(0.15))
                        .background {
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(tint.opacity(tint == .gray ? 0.15 : 1), lineWidth: 2)
                        }
                }
        }
    }
}

struct GameFirstView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList()
            .environmentObject(ModelData())
    }
}
