import SwiftUI

struct Question {
    var question: Word
    var options: [Word]
    var tappedAnswer: String = ""
    
    init() {
        let word = Word(id: "", russian: "", kalmyk: "", category: "", image: "")
        self.question = word
        self.options = []
    }
    init(question: Word, options: [Word], tappedAnswer: String = "") {
        self.question = question
        self.options = options
        self.tappedAnswer = tappedAnswer
    }
}

func makeQuestion(_ words: [Word],_ countOptions: Int) -> Question {
    let correctAnswer = Int.random(in: 0...words.count - 1)
    var ans1: Int
    var ans2: Int
    var ans3: Int
    
    repeat {
        ans1 = Int.random(in: 0...words.count - 1)
    } while (ans1 == correctAnswer)
    var array = [correctAnswer, ans1]
    
    if countOptions == 4 {
        repeat {
            ans2 = Int.random(in: 0...words.count - 1)
            ans3 = Int.random(in: 0...words.count - 1)
        } while (ans3 == ans1 || ans3 == ans2 || ans3 == correctAnswer || ans2 == correctAnswer || ans2 == ans1)
        array.append(ans2)
        array.append(ans3)
    }
    array.shuffle()
    
    var options: [Word] = []
    for option in array {
        options.append(words[option])
    }
    return Question(question: words[correctAnswer], options: options)
}
