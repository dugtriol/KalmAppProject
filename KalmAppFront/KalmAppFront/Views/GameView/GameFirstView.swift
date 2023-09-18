//
//  GameFirstView.swift
//  KalmAppFront
//
//  Created by Айгуль Манджиева on 18.09.2023.
//

import SwiftUI

struct GameFirstView: View {
    @State private var progress: CGFloat = 0.0
    @State private var words: [Word] = []
    @EnvironmentObject private var modelData: ModelData
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var userAnswer = -1
    
    init(words: [Word]) {
        self.words = words
    }
    
    /// - View Properties
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(spacing: 15) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .hAllign(.leading)
            
            GeometryReader {
                let size = $0.size
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(.black.opacity(0.2))
                    Rectangle()
                        .fill(Color(.blue))
                        .frame(width: progress*size.width, alignment: .leading)
                }
                .clipShape(Capsule())
            }
            .frame(height: 20)
            .padding(.top, 5)
        }
        .padding(15)
        .hAllign(.center).vAllign(.top)
        .background {
            Color(.gray)
                .ignoresSafeArea()
        }
    }
    
    func updateAnswers() {
        //words.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            print("correct")
            //progress += 0.1
        } else {
            print("not correct")
        }
    }
}

struct GameFirstView_Previews: PreviewProvider {
    static var previews: some View {
        GameFirstView(words: words)
            .environmentObject(ModelData())
    }
}


let words = [Word(id: UUID().uuidString, russian: "mother", kalmyk: "motherk", category: "family"), Word(id: UUID().uuidString, russian: "father", kalmyk: "fatherk", category: "family"), Word(id: UUID().uuidString, russian: "sister", kalmyk: "sisterk", category: "family"), Word(id: UUID().uuidString, russian: "brother", kalmyk: "brotherk", category: "family")]
