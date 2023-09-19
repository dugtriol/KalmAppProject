//
//  ScoreCardView.swift
//  KalmAppFront
//
//  Created by Айгуль Манджиева on 19.09.2023.
//

import SwiftUI

struct ScoreCardView: View {
    var score: CGFloat
    /// - Moving to Home When This View was Dismissed
    var onDismiss: () -> ()
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            VStack(spacing: 15) {
                Text("Results of your Exercise")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    Text("Congratulations! You\n have score")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    
                    Text(String(format: "%.0f", score) + "%")
                        .font(.title.bold())
                        .padding(.bottom, 10)
                    
                    Image(systemName: "star")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 220)
                }
                .foregroundColor(.black)
                .padding(.horizontal, 15)
                .padding(.vertical, 20)
                .hAllign(.center)
                .background {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(.white)
                }
            }
            .vAllign(.center)
            
            SelectButton(title: "Back To Home") {
                onDismiss()
                dismiss()
            }
        }
        .padding(15)
        .background {
            Color(.gray)
                .ignoresSafeArea()
        }
    }
}

//struct ScoreCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScoreCardView(score: 50.0)
//    }
//}
