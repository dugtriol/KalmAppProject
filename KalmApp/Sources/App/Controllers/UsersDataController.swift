import Vapor
import Fluent

struct UsersDataController: RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        let dataGroup = routes.grouped("data")
        dataGroup.get(":userId", ":categoryId", ":nameLesson", use: getHandler)
        dataGroup.post(use: createHandler)
        dataGroup.put(":userId", ":categoryId", ":nameLesson", use: updateHandler)
    }
    
    //MARK: CRUD - Create
    func createHandler(_ req: Request) async throws ->  UserData {
        guard let data = try? req.content.decode(UserData.self) else {
            throw Abort(.custom(code: 499, reasonPhrase: "Не удалось декодировать модель UserData"))
        }
        try await data.save(on: req.db)
        return data
    }
    
    //MARK: CRUD - Retrieve
    func getHandler(_ req: Request) async throws -> UserData {
        guard let data = try await UserData.query(on: req.db)
            .filter(\.$userID == req.parameters.get("userId")!)
            .filter(\.$categoryID == req.parameters.get("categoryId")!)
            .filter(\.$name == req.parameters.get("nameLesson")!)
            .first()
        else {
            throw Abort(.notFound)
        }
        return data
    }
    
    //MARK: CRUD - Update
    func updateHandler(_ req: Request) async throws -> UserData {
        let updatedData = try req.content.decode(UserData.self)
        
        guard let data = try await UserData.query(on: req.db)
            .filter(\.$userID == req.parameters.get("userId")!)
            .filter(\.$categoryID == req.parameters.get("categoryId")!)
            .filter(\.$name == req.parameters.get("nameLesson")!)
            .first()
        else {
            try await updatedData.save(on: req.db)
            return updatedData
        }
        data.correctAnswers = updatedData.correctAnswers
        data.allAnswers = updatedData.allAnswers
        try await data.save(on: req.db)
        return data
    }
}
