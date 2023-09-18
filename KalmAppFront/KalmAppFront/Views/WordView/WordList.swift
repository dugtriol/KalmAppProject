//
//  WordList.swift
//  KalmAppFront
//
//  Created by Айгуль Манджиева on 18.09.2023.
//

import SwiftUI

struct WordList: View {
    var category: Category
    @EnvironmentObject private var modelData: ModelData
    var body: some View {
        List(modelData.words, id: \.id) { word in
            WordCell(word: word)
        }
        .task {
            do {
                try await modelData.fetchWordsByCaetgory(id: category.id)
            } catch {
                print("error LessonList")
            }
        }
    }
}

//struct WordList_Previews: PreviewProvider {
//    static var previews: some View {
//        WordList()
//    }
//}
