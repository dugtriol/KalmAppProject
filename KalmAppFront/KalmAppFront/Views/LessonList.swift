//
//  LessonList.swift
//  KalmAppFront
//
//  Created by Айгуль Манджиева on 17.09.2023.
//

import SwiftUI

struct LessonList: View {
    @EnvironmentObject private var modelData: ModelData
    var body: some View {
        List(modelData.words, id: \.id) { word in
            LessonCell(word: word)
        }
        .task {
            do {
                try await modelData.fetchWords()
            } catch {
                print("error LessonList")
            }
        }
    }
}

struct LessonList_Previews: PreviewProvider {
    static var previews: some View {
        LessonList()
            .environmentObject(ModelData())
    }
}

