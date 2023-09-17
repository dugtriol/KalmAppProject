//
//  KalmAppFrontApp.swift
//  KalmAppFront
//
//  Created by Айгуль Манджиева on 17.09.2023.
//

import SwiftUI

@main
struct KalmAppFrontApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            LessonList()
                .environmentObject(modelData)
        }
    }
}
