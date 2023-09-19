//
//  Question.swift
//  KalmAppFront
//
//  Created by Айгуль Манджиева on 19.09.2023.
//

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

func makeQuestion(_ words: [Word]) -> Question {
    let correctAnswer = Int.random(in: 0...words.count - 1)
    var ans1: Int
    var ans2: Int
    var ans3: Int
    repeat {
        ans1 = Int.random(in: 0...words.count - 1)
        ans2 = Int.random(in: 0...words.count - 1)
        ans3 = Int.random(in: 0...words.count - 1)
    } while (ans1 == ans2 || ans1 == correctAnswer || ans2 == correctAnswer || ans3 == ans1 || ans3 == ans2 || ans3 == correctAnswer)
    
    var array = [correctAnswer, ans1, ans2, ans3]
    array.shuffle()
    return Question(question: words[correctAnswer], options: [words[array[0]], words[array[1]], words[array[2]], words[array[3]]])
}
