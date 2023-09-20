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
        NavigationStack {
            List (modelData.categories, id: \.id) { category in
                NavigationLink(value: category) {
                    CategoryCell(category: category)
                }
            }
            .navigationDestination(for: Category.self, destination: { category in
                GameHomeView(category: category)
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

