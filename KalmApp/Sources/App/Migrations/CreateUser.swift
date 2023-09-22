import Fluent
import Vapor

struct CreateUser: AsyncMigration {
    func revert(on database: FluentKit.Database) async throws {
        try await database.schema("users").delete()
    }
    
    func prepare(on database: FluentKit.Database) async throws {
        let schema = database.schema("users")
            .id()
            .field("name", .string, .required)
            .field("login", .string, .required)
            .field("password", .string, .required)
            .unique(on: "login")
        try await schema.create()
    }
}

