//
//  ScoreCardView.swift
//  KalmAppFront
//
//  Created by Айгуль Манджиева on 19.09.2023.
//

import SwiftUI

struct ScoreCardView: View {
    var score: Int
    var countOfQuestions: Int
    /// - Moving to Home When This View was Dismissed
    var onDismiss: () -> ()
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            Color("BgColor").edgesIgnoringSafeArea(.all)
            VStack {
                VStack(spacing: 15) {

                    VStack(spacing: 15) {
                        HStack {
                            Image(systemName: (CGFloat(score)/CGFloat(countOfQuestions) * 100 < 20) ? "star" : "star.fill")
                            Image(systemName: CGFloat(score)/CGFloat(countOfQuestions) * 100 < 51 ? "star" : "star.fill")
                            Image(systemName: CGFloat(score)/CGFloat(countOfQuestions) * 100 < 86 ? "star" : "star.fill")
                        }
                        .foregroundColor(Color(.orange))
                        .font(.system(size: 60))
                        .padding(.bottom, 40)
                        
                        Text("Задание\nзавершено!")
                            .font(.system(size: 35))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 30)
                        
                        VStack {
                            HStack {
                                Text("Всего заданий: ")
                                    .padding(.trailing, 70)
                                Text("\(countOfQuestions)")
                            }
                            HStack {
                                Text("Правильные ответы: ")
                                    .padding(.trailing, 30)
                                Text("\(score)")
                                    
                            }
                        }
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .font(.title3)
                        .padding(.vertical)
                        .padding(.horizontal)
                        .background {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(Color("PrimaryColor").opacity(0.9))
                        }
                    }
                    .foregroundColor(Color("TitleTextColor"))
                    .padding(.horizontal, 15)
                    .padding(.vertical, 20)
                    .hAllign(.center)
                }
                .vAllign(.center)
                
                SelectButton(title: "Продолжить") {
                    onDismiss()
                    dismiss()
                }
            }
            .padding(15)
        }
    }
}

struct ScoreCardView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreCardView(score: 8, countOfQuestions: 10, onDismiss: {})
    }
}
