import Vapor
import Fluent

struct CreateCategory: AsyncMigration {
    func prepare(on database: FluentKit.Database) async throws {
        let schema = database.schema("categories")
            .id()
            .field("titleRussian", .string, .required)
            .field("titleKalmyk", .string, .required)
            .field("image", .string, .required)
        
        try await schema.create()
    }
    
    func revert(on database: FluentKit.Database) async throws {
        try await database.schema("categories").delete()
    }
}
