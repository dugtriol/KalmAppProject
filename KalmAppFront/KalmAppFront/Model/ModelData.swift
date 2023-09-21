import Foundation

@MainActor
final class ModelData: ObservableObject {
    @Published var words: [Word] = []
    @Published var categories: [Category] = []
    
    func fetchWordsByCaetgory(id: String) async throws {
        words = try await NetworkService.shared.getWordsByCategory(id: id)
    }
    
    func fetchCategories() async throws {
        categories = try await NetworkService.shared.getCategories()
    }

}
