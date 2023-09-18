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
//            List {
//                ForEach (modelData.categories, id: \.self) {
//                    category in NavigationLink {
//                        GameHomeView(categoryID: category.id)
//                    } label: {
//                        CategoryCell(category: category)
//                    }
//                }
            List (modelData.categories, id: \.id) { category in
                NavigationLink(value: category) {
                    CategoryCell(category: category)
                }
            }
            .navigationDestination(for: Category.self, destination: { category in
                GameHomeView(categoryID: category.id)
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

