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
    
    var words: [Word]
    @State var question: Question
    
    init(words: [Word]) {
        self.words = words
        self.words.shuffle()
        _question = State(initialValue: makeQuestion(self.words))
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
                //self.question = makeQuestion()
                ForEach(0..<countOfQuestions) { index in
                    QuestionView(question)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
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
                    withAnimation(.easeInOut) {
                        self.question = makeQuestion(self.words)
                        currentIndex += 1
                        progress = CGFloat(currentIndex) / CGFloat(countOfQuestions - 1)
                    }
                }
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
                print("\(score) \(countOfQuestions)")
            }
        }
    }
    
    
    @ViewBuilder
    func QuestionView(_ question: Question) -> some View{
        VStack(alignment: .leading, spacing: 15) {
            //            Text("Question \(currentIndex + 1)/\(10)")
            //                .font(.callout)
            //                .foregroundColor(.black)
            //                .hAllign(.leading)
            Text(question.question.kalmyk)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.black)
            VStack(spacing: 12) {
                ForEach(question.options, id: \.self) { option in
                    /// Displaying Correct and Wrong answers  after user has tapped any one of the options
                    ZStack {
                        OptionView(option, .gray)
                            .opacity(question.question.id == option.id && question.tappedAnswer != "" ? 0 : 1)
                        OptionView(option, .green)
                            .opacity(question.question.id == option.id && question.tappedAnswer != "" ? 1 : 0)
                        OptionView(option, .red)
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
    func OptionView(_ option: Word, _ tint: Color) -> some View {
        Text(option.russian)
            .foregroundColor(tint)
            .padding(.horizontal, 15)
            .padding(.vertical, 20)
            .hAllign(.leading)
            .background {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(tint.opacity(0.15))
                    .background{
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(tint.opacity(tint == .gray ? 0.15 : 1), lineWidth: 2)
                    }
            }
        
    }
}

struct GameFirstView_Previews: PreviewProvider {
    static var previews: some View {
        GameHomeView(categoryID: "5339a41e-dcd5-4167-87da-edf609a03124")
            .environmentObject(ModelData())
    }
}
