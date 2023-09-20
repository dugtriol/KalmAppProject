import Foundation

struct Word: Identifiable, Codable, Hashable {
    var id: String
    var russian: String
    var kalmyk: String
    var category: String
    var image: String
}

func returnArrayWord(_ words: [Word]) -> [Word] {
    let correctAnswer = Int.random(in: 0...words.count - 1)
    var ans1: Int

    repeat {
        ans1 = Int.random(in: 0...words.count - 1)
    } while (ans1 == correctAnswer)
    
    var array = [correctAnswer, ans1]
    array.shuffle()
    return [words[array[0]], words[array[1]]]
}
//
//enum Category: String, CaseIterable {
//    case Greeting = "Приветствие"
//}
