//
//  ContentView.swift
//  KalmAppFront
//
//  Created by Айгуль Манджиева on 20.09.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var modelData = ModelData()
    @State private var  showSignUp: Bool = false
    @State private var  showCategoryList: Bool = false
    @State var user: User?
    
    var body: some View {
        NavigationStack {
            LoginView(showSignUp: $showSignUp, showCategoryList: $showCategoryList, user: $user)
                .navigationDestination(isPresented: $showSignUp) {
                    SignUpView(showSignUp: $showSignUp, showCategoryList: $showCategoryList, user: $user)
                }
            
        }
        .fullScreenCover(isPresented: $showCategoryList, content: {
            CategoryList(user: $user)
                .environmentObject(modelData)
        })
        .accentColor(Color("PrimaryColor"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
