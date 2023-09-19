//
//  GameFirstView.swift
//  KalmAppFront
//
//  Created by Айгуль Манджиева on 18.09.2023.
//

import SwiftUI

struct GameFirstView: View {
    //var gameModel: GameModel
    @State private var progress: CGFloat = 0.0
    var words: [Word] = []
    @State var question: Question = Question(question: "mother", options: ["motherk", "fatherk", "sisterk"], answer: "motherk")
    
    
    init(words: [Word]) {
        self.words = words
        self.words.shuffle()
    }
    
    func makeQuestion() -> Question {
        let correctAnswer = Int.random(in: 0...self.words.count - 1)
        var ans1: Int
        var ans2: Int
        repeat {
            ans1 = Int.random(in: 0...self.words.count - 1)
            ans2 = Int.random(in: 0...self.words.count - 1)
        } while (ans1 == ans2 || ans1 == correctAnswer || ans2 == correctAnswer)
        
        var array = [correctAnswer, ans1, ans2]
        array.shuffle()
        return Question(question: words[correctAnswer].russian, options: [words[array[0]].kalmyk, words[array[1]].kalmyk, words[array[2]].kalmyk], answer: words[correctAnswer].kalmyk)
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
                ForEach(0..<10) { index in
                    QuestionView(question)
                }
            }
            .padding(.horizontal, -15)
            .padding(.vertical, 15)
            
            SelectButton(title: "Next Question", onClick: {
                withAnimation(.easeInOut) {
                    self.question = makeQuestion()
                }
            })
        }
        .padding(15)
        .hAllign(.center).vAllign(.top)
        .background {
            Color(.gray)
                .ignoresSafeArea()
        }
    }
    
    
    @ViewBuilder
    func QuestionView(_ question: Question) -> some View{
        VStack(alignment: .leading, spacing: 15) {
            //            Text("Question \(currentIndex + 1)/\(10)")
            //                .font(.callout)
            //                .foregroundColor(.black)
            //                .hAllign(.leading)
            Text(question.question)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.black)
            VStack(spacing: 12) {
                ForEach(question.options, id: \.self) { option in
                    /// Displaying Correct and Wrong answers  after user has tapped any one of the options
                    ZStack {
                        OptionView(option, .gray)
                            .opacity(question.answer == option && question.tappedAnswer != "" ? 0 : 1)
                        OptionView(option, .green)
                            .opacity(question.answer == option && question.tappedAnswer != "" ? 1 : 0)
                        OptionView(option, .red)
                            .opacity(question.tappedAnswer == option && question.tappedAnswer != question.answer ? 1 : 0)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        /// Disabling Tap if Already Answer was selected
                        guard question.tappedAnswer == "" else {return}
                        self.question.tappedAnswer = option
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
    func OptionView(_ option: String, _ tint: Color) -> some View {
        Text(option)
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
