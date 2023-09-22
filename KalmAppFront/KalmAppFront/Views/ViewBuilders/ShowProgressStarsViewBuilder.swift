import SwiftUI

@ViewBuilder
func showProgressStars(correctAnswers: Int, allAnswers: Int) -> some View {
    HStack {
        Image(systemName: (CGFloat(correctAnswers)/CGFloat(allAnswers) * 100 < 20) ? "star" : "star.fill")
        Image(systemName: (CGFloat(correctAnswers)/CGFloat(allAnswers) * 100 < 51) ? "star" : "star.fill")
        Image(systemName: (CGFloat(correctAnswers)/CGFloat(allAnswers) * 100 < 86) ? "star" : "star.fill")
    }
}
