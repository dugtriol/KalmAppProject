//
//  PrimaryButton.swift
//  KalmAppFront
//
//  Created by Айгуль Манджиева on 20.09.2023.
//

import SwiftUI

struct PrimaryButton: View {
    var title: String
    var onClick: () -> ()
    var body: some View {
        Button {
            onClick()
        } label: {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color("PrimaryColor"))
                .cornerRadius(50)
        }
    }
}

//struct PrimaryButton_Previews: PreviewProvider {
//    static var previews: some View {
//        PrimaryButton(title: "Title")
//    }
//}
