//
//  View+.swift
//  KalmAppFront
//
//  Created by Айгуль Манджиева on 18.09.2023.
//

import SwiftUI

extension View {
    func hAllign(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vAllign(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
}
