import Foundation
import SwiftUI

protocol ExerciseModel {
    var name: String { get set }
    var userID: String { get set }
    var categoryID: String { get set }
    var progress: CGFloat { get set }
    var currentIndex: Int { get set }
    var score: Int { get set }
    var countOfQuestions: Int { get set }
    var showScoreCard: Bool { get set }
    var question: Question { get set }
}
