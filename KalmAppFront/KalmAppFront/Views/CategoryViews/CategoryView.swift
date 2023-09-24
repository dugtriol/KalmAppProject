import SwiftUI

struct CategoryView: View {
    @EnvironmentObject private var modelData: ModelData
    var category: Category
    @State private var startQuizz: Bool = false
    @State private var startDictionary: Bool = false
    @State var userId: String
    
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
                                Text("\(modelData.userDataDictionary.correctAnswers)/\(modelData.userDataDictionary.allAnswers)")
                            }
                            .padding(.bottom, 15)
                            HStack {
                                showProgressStars(correctAnswers: modelData.userDataDictionary.correctAnswers, allAnswers: modelData.userDataDictionary.allAnswers)
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
                    .fullScreenCover(isPresented: $startDictionary) {
                        DictionaryView(words: modelData.words, userID: userId, categoryID: category.id)
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
                                Text("\(modelData.userDataLesson_1.correctAnswers)/\(modelData.userDataLesson_1.allAnswers)")
                            }
                            .padding(.bottom, 15)
                            HStack {
                                showProgressStars(correctAnswers: modelData.userDataLesson_1.correctAnswers, allAnswers: modelData.userDataLesson_1.allAnswers)
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
                        LessonView(words: modelData.words, userID: userId, categoryID: category.id)
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
            .task {
                do {
                    try await modelData.fetchUserData(userID: userId, categoryID: category.id, name: "Dictionary")
                } catch {
                    modelData.userDataDictionary.correctAnswers = 0
                    modelData.userDataDictionary.allAnswers = 10
                }
            }
            .task {
                do {
                    try await modelData.fetchUserData(userID: userId, categoryID: category.id, name: "Lesson_1")
                } catch {
                    modelData.userDataLesson_1.correctAnswers = 0
                    modelData.userDataLesson_1.allAnswers = 10
                }
            }
            .vAllign(.top)
        }
    }
}
