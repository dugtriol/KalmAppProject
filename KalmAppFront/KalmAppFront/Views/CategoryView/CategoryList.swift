//
//  LessonList.swift
//  KalmAppFront
//
//  Created by Айгуль Манджиева on 17.09.2023.
//

import SwiftUI

struct CategoryList: View {
    @EnvironmentObject private var modelData: ModelData
    var body: some View {
        NavigationView {
            List {
                ForEach (modelData.categories, id: \.self) {
                    category in NavigationLink {
                        WordList(category: category)
                    } label: {
                        CategoryCell(category: category)
                    }
                }
            }
            .navigationDestination(for: Category.self, destination: { category in
                WordList(category: category)
            })
        }
        .navigationTitle("categories")
        .task {
            do {
                try await modelData.fetchCategories()
            } catch {
                print("error LessonList")
            }
        }
    }
}

struct LessonList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList()
            .environmentObject(ModelData())
    }
}

