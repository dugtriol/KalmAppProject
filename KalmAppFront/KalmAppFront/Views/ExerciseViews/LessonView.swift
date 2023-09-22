import SwiftUI

struct LessonView: View, ExerciseModel {
    @State internal var countOfQuestions: Int = 10
    @State internal var name: String = "Lesson_1"
    @State internal var userID: String
    @State internal var categoryID: String
    @State internal var progress: CGFloat = 0.0
    @State internal var currentIndex: Int = 0
    @State internal var score: Int = 0
    @State internal var showScoreCard: Bool = false
    
    @State private var method: Int = 0
    var words: [Word]
    @State var question: Question
    
    init(words: [Word], userID: String, categoryID: String) {
        self.words = words
        self.words.shuffle()
        _question = State(initialValue: makeQuestion(self.words, 4))
        self._userID = State(initialValue: userID)
        self._categoryID = State(initialValue: categoryID)
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
                            .fill(Color("TitleTextColor").opacity(0.2))
                        Rectangle()
                            .fill(Color("PrimaryColor"))
                            .frame(width: progress*size.width, alignment: .leading)
                    }
                    .clipShape(Capsule())
                }
                .frame(height: 20)
                .padding(.top, 5)
                
                /// Questions
                GeometryReader { _ in
                    ForEach(0..<countOfQuestions, id:\.self) { index in
                        if currentIndex == index {
                            QuestionView(question, method)
                        }
                    }
                }
                .padding(.horizontal, -15)
                .padding(.vertical, 15)
                
                /// - Changing Button to Finish When the Last Question Arrived
                SelectButton(title: currentIndex == (countOfQuestions - 1) ? "Завершить" : "Следующий вопрос", onClick: {
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
            .fullScreenCover(isPresented: $showScoreCard) {
                /// - Displaying in 100%
                ScoreCardView(categoryId: $categoryID, userId: $userID, name: $name, score: score, countOfQuestions: countOfQuestions) {
                    /// - Closing View
                    dismiss()
                }
            }
        }
    }
}
