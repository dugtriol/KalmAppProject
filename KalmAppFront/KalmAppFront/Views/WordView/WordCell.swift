//
//  WordCell.swift
//  KalmAppFront
//
//  Created by Айгуль Манджиева on 18.09.2023.
//

import SwiftUI

struct WordCell: View {
    var word: Word
    var body: some View {
        HStack {
            Image(systemName: "flame")
                .resizable()
                .frame(width: 70, height: 70)
                .aspectRatio(contentMode: .fill)
                .clipShape(Rectangle())
            VStack (alignment: .leading, spacing: 5){
                Text(word.kalmyk)
                Text(word.russian)
            }.bold()
            Spacer()
        }
    }
}

//struct WordCell_Previews: PreviewProvider {
//    static var previews: some View {
//        WordCell()
//    }
//}
