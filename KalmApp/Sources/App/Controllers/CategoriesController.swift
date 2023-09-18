import Vapor
import Fluent

struct CategoriesController: RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        let categoryGroup = routes.grouped("categories")
        categoryGroup.get(use: getAllHandler(_:))
        categoryGroup.get(":categoryID", use: getHandler)
        categoryGroup.post(use: createHandler)
        categoryGroup.delete(":categoryID", use: deleteHandler)
    }
    
    //MARK: CRUD - Create
    func createHandler(_ req: Request) async throws -> Category {
        guard let category = try? req.content.decode(Category.self) else {
            throw Abort(.custom(code: 499, reasonPhrase: "Не удалось декодировать модель Category"))
        }
        let imagePath = "\(req.application.directory.workingDirectory)" + "Storage/Categories/\(category.image).jpg"
        category.image = imagePath
        try await category.save(on: req.db)
        return category
    }
    
//    //MARK: CRUD - Create
//    func createHandlers(_ req: Request) async throws -> [Word] {
//        guard let words = try? req.content.decode([Word].self) else {
//            throw Abort(.custom(code: 499, reasonPhrase: "Не удалось декодировать модель Word"))
//        }
//        for word in words {
//            let imagePath = "\(req.application.directory.workingDirectory)" + "Storage/Words/\(word.image).jpg"
//            word.image = imagePath
//            try await word.save(on: req.db)
//        }
//        return words
//    }
    
    //MARK: CRUD - Retrieve All
    func getAllHandler(_ req: Request) async throws -> [Category] {
        let category = try await Category.query(on: req.db).all()
        return category
    }
    
    //MARK: CRUD - Retrieve
    func getHandler(_ req: Request) async throws -> Category {
        guard let category = try await Category.find(req.parameters.get("categoryID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return category
    }
    
    //MARK: CRUD - Delete
    func deleteHandler(_ req: Request) async throws -> HTTPStatus {
        guard let category = try await Category.find(req.parameters.get("categoryID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await category.delete(on: req.db)
        return .ok
    }
}
