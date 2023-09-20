//
//  GameHomeView.swift
//  KalmAppFront
//
//  Created by Айгуль Манджиева on 18.09.2023.
//

import SwiftUI

struct GameHomeView: View {
    @EnvironmentObject private var modelData: ModelData
    var category: Category
    @State private var startQuizz: Bool = false
    @State private var startDictionary: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(category.titleKalmyk)
                    Text(category.titleRussian)
                }
                .padding()
                Image(systemName: "star")
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Rectangle())
                    .padding()
                    .background(Color.red)
            }
            .background{
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.gray)
            }
            .padding(15)
            .hAllign(.center).vAllign(.top)

            Button {
                startQuizz.toggle()
            } label: {
                Text("Упражнение")
            }
            .fullScreenCover(isPresented: $startQuizz) {
                GameFirstView(words: modelData.words)
            }
            Button {
                startDictionary.toggle()
            } label: {
                Text("Словарь")
            }
            .fullScreenCover(isPresented: $startDictionary) {
                DictionaryView(words: modelData.words)
            }
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

struct GameHomeView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList()
            .environmentObject(ModelData())
    }
}
