//
//  GameHomeView.swift
//  KalmAppFront
//
//  Created by Айгуль Манджиева on 18.09.2023.
//

import SwiftUI

struct GameHomeView: View {
    @EnvironmentObject private var modelData: ModelData
    var categoryID: String
    @State private var startQuizz: Bool = false
    
    var body: some View {
        VStack {
            Button {
                startQuizz.toggle()
            } label: {
                Text("Упражнение")
            }
        }
        .fullScreenCover(isPresented: $startQuizz) {
            GameFirstView(words: modelData.words)
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

struct GameHomeView_Previews: PreviewProvider {
    static var previews: some View {
        GameHomeView(categoryID: "5339a41e-dcd5-4167-87da-edf609a03124")
            .environmentObject(ModelData())
    }
}
