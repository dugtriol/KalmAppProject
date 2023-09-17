import Foundation

struct Word: Identifiable, Codable {
    var id: String
    var russian: String
    var kalmyk: String
    var category: String
    var image: String?
}
//
//enum Category: String, CaseIterable {
//    case Greeting = "Приветствие"
//}
