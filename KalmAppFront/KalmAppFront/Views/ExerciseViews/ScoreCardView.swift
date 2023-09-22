import SwiftUI

struct ScoreCardView: View {
    @EnvironmentObject private var modelData: ModelData
    @Binding var categoryId: String
    @Binding var userId: String
    @Binding var name: String
    var score: Int
    var countOfQuestions: Int
    
    /// - Moving to Home When This View was Dismissed
    var onDismiss: () -> ()
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            Color("BgColor").edgesIgnoringSafeArea(.all)
            VStack {
                VStack(spacing: 15) {
                    VStack(spacing: 15) {
                        showProgressStars(correctAnswers: score, allAnswers: countOfQuestions)
                            .foregroundColor(Color(.orange))
                            .font(.system(size: 60))
                            .padding(.bottom, 40)
                        
                        Text("Задание\nзавершено!")
                            .font(.system(size: 35))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 30)
                        
                        VStack {
                            HStack {
                                Text("Всего заданий: ")
                                    .padding(.trailing, 70)
                                Text("\(countOfQuestions)")
                            }
                            HStack {
                                Text("Правильные ответы: ")
                                    .padding(.trailing, 30)
                                Text("\(score)")
                            }
                        }
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .font(.title3)
                        .padding(.vertical)
                        .padding(.horizontal)
                        .background {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(Color("PrimaryColor").opacity(0.9))
                        }
                    }
                    .foregroundColor(Color("TitleTextColor"))
                    .padding(.horizontal, 15)
                    .padding(.vertical, 20)
                    .hAllign(.center)
                }
                .vAllign(.center)
                
                SelectButton(title: "Продолжить") {
                    onDismiss()
                    dismiss()
                }
                .task {
                    do {
                        try await NetworkService.shared.updateUserData(userID: userId, categoryID: categoryId, name: name, correctAnswers: score, allAnswers: countOfQuestions)
                    } catch {
                        print("error ScoreCardView")
                    }
                }
            }
            .padding(15)
        }
    }
}
