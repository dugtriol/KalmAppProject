import Vapor
import Fluent

struct CreateUserData: AsyncMigration {
    func prepare(on database: FluentKit.Database) async throws {
        let schema = database.schema("data")
            .id()
            .field("userID", .string, .required)
            .field("categoryID", .string, .required)
            .field("name", .string, .required)
            .field("correctAnswers", .int, .required)
            .field("allAnswers", .int, .required)
        try await schema.create()
    }
    
    func revert(on database: FluentKit.Database) async throws {
        try await database.schema("data").delete()
    }
}
