import SwiftUI

extension LessonView {
    @ViewBuilder
    func QuestionView(_ question: Question, _ method: Int) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Вопрос \(currentIndex + 1)/\(countOfQuestions)")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .hAllign(.leading)
            Text(method == 0 ? question.question.russian : question.question.kalmyk)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
            VStack(spacing: 12) {
                ForEach(question.options, id: \.self) { option in
                    /// - Displaying Correct and Wrong answers  after user has tapped any one of the options
                    ZStack {
                        OptionView(option, .white, method == 0 ? 0 : method == 1 ? 1 : 2)
                            .opacity(question.question.id == option.id && question.tappedAnswer != "" ? 0 : 1)
                        OptionView(option, .green, method == 0 ? 0 : method == 1 ? 1 : 2)
                            .opacity(question.question.id == option.id && question.tappedAnswer != "" ? 1 : 0)
                        OptionView(option, .red, method == 0 ? 0 : method == 1 ? 1 : 2)
                            .opacity(question.tappedAnswer == option.id && question.tappedAnswer != question.question.id ? 1 : 0)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        /// - Disabling Tap if Already Answer was selected
                        guard question.tappedAnswer == "" else {return}
                        self.question.tappedAnswer = option.id
                        if self.question.question.id == self.question.tappedAnswer {
                            score += 1
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
                .fill(Color("PrimaryColor")).opacity(0.8)
        }
        .padding(.horizontal, 15)
    }
    
}
