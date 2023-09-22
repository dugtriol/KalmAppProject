import Foundation

@MainActor
final class ModelData: ObservableObject {
    @Published var words: [Word] = []
    @Published var categories: [Category] = []
    @Published var userDataDictionary: UserData = UserData()
    @Published var userDataLesson_1: UserData = UserData()
    
    func fetchWordsByCaetgory(id: String) async throws {
        words = try await NetworkService.shared.getWordsByCategory(id: id)
    }
    
    func fetchCategories() async throws {
        categories = try await NetworkService.shared.getCategories()
    }
    
    func fetchUserData(userID: String, categoryID: String, name: String) async throws {
        if name == "Dictionary" {
            userDataDictionary = try await NetworkService.shared.getUserData(userID: userID, categoryID: categoryID, name: name)
        }
        else {
            userDataLesson_1 = try await NetworkService.shared.getUserData(userID: userID, categoryID: categoryID, name: name)
        }
    }
}
