//
//  GameFirstView.swift
//  KalmAppFront
//
//  Created by Айгуль Манджиева on 18.09.2023.
//

import SwiftUI

struct GameFirstView: View {
    @State private var words: [Word]
    @State private var correctAnswer = Int.random(in: 0...2)
    
    init(words: [Word]) {
        self.words = words
    }
    
    var body: some View {
        
        VStack {
            VStack {
                Text("Choose word")
                Text(words[correctAnswer].kalmyk)
            }
            ForEach (0..<3) { number in
                Button(action: {
                    self.flagTapped(number)
                    updateAnswers()
                }) {
                    Text(words[number].russian)
                }
            }
        }
    }
    
    func updateAnswers() {
        self.words.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {

        } else {

        }
    }
}

struct GameFirstView_Previews: PreviewProvider {
    static var previews: some View {
        GameFirstView(words: ModelData().words)
            .environmentObject(ModelData())
    }
}


let words = [Word(id: UUID().uuidString, russian: "", kalmyk: <#T##String#>, category: <#T##String#>), Word(id: <#T##String#>, russian: <#T##String#>, kalmyk: <#T##String#>, category: <#T##String#>), Word(id: <#T##String#>, russian: <#T##String#>, kalmyk: <#T##String#>, category: <#T##String#>), Word(id: <#T##String#>, russian: <#T##String#>, kalmyk: <#T##String#>, category: <#T##String#>)]
