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
        ZStack {
            Color("BgColor").edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(category.titleKalmyk)
                            .font(.system(size: 35, weight: .bold))
                        Text(category.titleRussian)
                            .font(.system(size: 25))
                    }
                    .foregroundColor(Color("TitleTextColor"))
                    Spacer(minLength: 0)
                    Image(category.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .cornerRadius(15)
                }
                .padding(.horizontal)
                .padding(.bottom, 50)
                
                HStack {
                    Button {
                        startDictionary.toggle()
                    } label: {
                        VStack(alignment: .leading) {
                            Image(systemName: "character.book.closed")
                                .frame(width: 40)
                                .font(.title2)
                                .padding(.bottom, 5)
                            HStack {
                                Text("Словарь")
                                    .font(.subheadline)
                                Spacer(minLength: 0)
                                Text("1/18")
                            }
                            .padding(.bottom, 15)
                            HStack {
                                Image(systemName: "star")
                                Image(systemName: "star")
                                Image(systemName: "star")
                                Spacer(minLength: 0)
                                Image(systemName: "checkmark.circle")
                            }
                            .font(.title2)
                            .padding(.bottom, 15)
                        }
                        .hAllign(.leading)
                        .frame(maxWidth: .infinity)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 15)
                        .background(Color("PrimaryColor"))
                        .clipShape(Rectangle())
                        .cornerRadius(15)
                        
                    }                    .fullScreenCover(isPresented: $startDictionary) {
                        DictionaryView(words: modelData.words)
                    }
                    
                    Spacer(minLength: 10)
                    Button {
                        startQuizz.toggle()
                    } label: {
                        VStack (alignment: .leading) {
                            Image(systemName: "brain")
                                .frame(width: 40)
                                .font(.title2)
                                .padding(.bottom, 5)
                            HStack {
                                Text("Упражнение")
                                    .font(.subheadline)
                                Spacer(minLength: 0)
                                Text("1/18")
                            }
                            .padding(.bottom, 15)
                            HStack {
                                Image(systemName: "star")
                                Image(systemName: "star")
                                Image(systemName: "star")
                                Spacer(minLength: 0)
                                Image(systemName: "checkmark.circle")
                            }
                            .font(.title2)
                            .padding(.bottom, 15)
                        }
                        .hAllign(.leading)
                        .frame(maxWidth: .infinity)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 15)
                        .background(Color("PrimaryColor"))
                        .clipShape(Rectangle())
                        .cornerRadius(15)
                    }
                    .fullScreenCover(isPresented: $startQuizz) {
                        GameFirstView(words: modelData.words)
                    }
                }
                .padding(.horizontal)
            }
            .task {
                do {
                    try await modelData.fetchWordsByCaetgory(id: category.id)
                } catch {
                    print("error LessonList")
                }
            }
            .vAllign(.top)
        }
    }
}

struct GameHomeView_Previews: PreviewProvider {
    static var previews: some View {
        //        GameHomeView(category: Category(id: "", titleRussian: "Russian", titleKalmyk: "Kalmyk", image: "family"))
        //            .environmentObject(ModelData())
        ContentView()
    }
}
