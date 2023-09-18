//
//  CustomButton.swift
//  KalmAppFront
//
//  Created by Айгуль Манджиева on 18.09.2023.
//

import SwiftUI

struct CustomButton<Content: View>: View {
    @State private var didTap: Bool = false
    
    let action: () -> Void
    let label: () -> Content
    
    init(action: @escaping () -> Void, @ViewBuilder label: @escaping () -> Content) {
        self.action = action
        self.label = label
    }
    
    init(action: @escaping () -> Void, title: String) where Content == Text {
        
        self.init(action: action, label: { Text(title) })
    }
    
    var body: some View {
        label().onTapGesture {
            action()
            didTap.toggle()
            
            
        }
        .frame(maxWidth: 270, maxHeight: 34)
            .padding()
            .foregroundColor(.white)
            .font(.title3).bold()
            .padding(.horizontal)
            .background(didTap ? Color.orange.opacity(0.7) : Color.orange.opacity(0.4))
            .cornerRadius(20)
    }
    
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(action: { print("hello") }, label: { Text("Button") })
            
    }
}
