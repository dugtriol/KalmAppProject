//
//  WordList.swift
//  KalmAppFront
//
//  Created by Айгуль Манджиева on 18.09.2023.
//

import SwiftUI

struct WordList: View {
    var categoryID: String
    @EnvironmentObject private var modelData: ModelData
    var body: some View {
        List(modelData.words, id: \.id) { word in
            WordCell(word: word)
        }
        .task {
            do {
                try await modelData.fetchWordsByCaetgory(id: categoryID)
            } catch {
                print("error LessonList")
            }
        }
    }
}

struct WordList_Previews: PreviewProvider {
    //static var category = ModelData().categories[1]
    static var previews: some View {
        WordList(categoryID: "5339a41e-dcd5-4167-87da-edf609a03124")
            .environmentObject(ModelData())
    }
}
