//
//  GameModel.swift
//  KalmAppFront
//
//  Created by Айгуль Манджиева on 19.09.2023.
//

import Foundation
import SwiftUI

struct GameModel {
    private var words: [Word] = []
    var questions: [Question] = []
    
    init() {}

    init(_ words: [Word]) {
        self.words = words
        for _ in (0..<10) {
            questions.append(makeQuestion())
        }
    }
    
    func printQuestion() {
        for item in questions.indices {
            print("\(questions[item].answer) \(questions[item].options[0]) \(questions[item].options[1]) \(questions[item].options[2])\n")
        }
    }
    
    private func makeQuestion() -> Question {
        let correctAnswer = Int.random(in: 0...words.count)
        var ans1: Int
        var ans2: Int
        repeat {
            ans1 = Int.random(in: 0...words.count)
            ans2 = Int.random(in: 0...words.count)
        } while (ans1 == ans2 && ans1 == correctAnswer && ans2 != correctAnswer)
        
        var array = [correctAnswer, ans1, ans2]
        array.shuffle()
        
        return Question(question: words[correctAnswer].russian, options: [words[array[0]].kalmyk, words[array[1]].kalmyk, words[array[2]].kalmyk], answer: words[correctAnswer].kalmyk)
    }
}
