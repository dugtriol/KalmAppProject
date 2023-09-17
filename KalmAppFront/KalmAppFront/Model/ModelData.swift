import Foundation

@MainActor
final class ModelData: ObservableObject {
    @Published var words: [Word] = []
    
    func fetchWords() async throws {
        words = try await NetworkService.shared.getWords()
    }
}
