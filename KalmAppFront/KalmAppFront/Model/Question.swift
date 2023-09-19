//
//  Question.swift
//  KalmAppFront
//
//  Created by Айгуль Манджиева on 19.09.2023.
//

import SwiftUI

struct Question {
    var question: String
    var options: [String]
    var answer: String
    
    var tappedAnswer: String = ""
    init() {
        self.question = "q"
        self.answer = ""
        self.options = []
    }
    init(question: String, options: [String], answer: String, tappedAnswer: String = "") {
        self.question = question
        self.options = options
        self.answer = answer
        self.tappedAnswer = tappedAnswer
    }
    
}
