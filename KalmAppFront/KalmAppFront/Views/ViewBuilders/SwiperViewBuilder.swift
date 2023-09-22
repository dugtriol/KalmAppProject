import SwiftUI

extension DictionaryView {
    @ViewBuilder
    func SwiperView() -> some View {
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
            ScoreCardView(categoryId: $categoryID, userId: $userID, name: $name, score: score, countOfQuestions: countOfQuestions) {
                /// - Closing View
                dismiss()
            }
        }
        .task {
            do {
                try await NetworkService.shared.updateUserData(userID: userID, categoryID: categoryID, name: name, correctAnswers: score, allAnswers: countOfQuestions)
            } catch {
                print("error ScoreCardView")
            }
        }
    }
}
