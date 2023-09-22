import Vapor
import Fluent

struct WordsController: RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        let wordGroup = routes.grouped("words")
        wordGroup.get(":categoryID", use: getAllHandlerByCategory)
        wordGroup.post(use: createHandlers)
        wordGroup.delete(":wordID", use: deleteHandler)
    }
    
    //    //MARK: CRUD - Create one Word
    //    func createHandler(_ req: Request) async throws -> Word {
    //        guard let word = try? req.content.decode(Word.self) else {
    //            throw Abort(.custom(code: 499, reasonPhrase: "Не удалось декодировать модель Word"))
    //        }
    //        let imagePath = "\(req.application.directory.workingDirectory)" + "Storage/Words/\(word.image).jpg"
    //        word.image = imagePath
    //        try await word.save(on: req.db)
    //        return word
    //    }
    
    //MARK: CRUD - Create array of Words
    func createHandlers(_ req: Request) async throws -> [Word] {
        guard let words = try? req.content.decode([Word].self) else {
            throw Abort(.custom(code: 499, reasonPhrase: "Не удалось декодировать модель Word"))
        }
        for word in words {
            try await word.save(on: req.db)
        }
        return words
    }
    
    //MARK: CRUD - Retrieve words by Category
    func getAllHandlerByCategory(_ req: Request) async throws -> [Word] {
        guard let category = try await Category.find(req.parameters.get("categoryID"), on: req.db) else {
            throw Abort(.badRequest)
        }
        let words = try await Word.query(on: req.db)
            .filter(\.$category == category.titleRussian)
            .all()
        return words
    }
    
    //MARK: CRUD - Delete
    func deleteHandler(_ req: Request) async throws -> HTTPStatus {
        guard let word = try await Word.find(req.parameters.get("wordID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await word.delete(on: req.db)
        return .ok
    }
}
