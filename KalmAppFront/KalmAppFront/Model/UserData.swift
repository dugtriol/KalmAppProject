import Foundation

struct UserData: Identifiable, Codable, Hashable {
    var id: String = ""
    var userID: String = ""
    var categoryID: String = ""
    var name: String = ""
    var correctAnswers: Int = 0
    var allAnswers: Int = 10
    
    init(id: String = "", userID: String = "", categoryID: String = "", name: String = "", correctAnswers: Int = 0, allAnswers: Int = 10) {
        self.id = id
        self.userID = userID
        self.categoryID = categoryID
        self.name = name
        self.correctAnswers = correctAnswers
        self.allAnswers = allAnswers
    }
}

struct UserDataUpdate: Codable {
    var userID: String
    var categoryID: String
    var name: String
    var correctAnswers: Int
    var allAnswers: Int
}
