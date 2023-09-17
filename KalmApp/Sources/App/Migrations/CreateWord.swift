import Vapor
import Fluent

struct CreateWord: AsyncMigration {
    func prepare(on database: FluentKit.Database) async throws {
        let schema = database.schema("words")
            .id()
            .field("russian", .string, .required)
            .field("kalmyk", .string, .required)
            .field("category", .string, .required)
            .field("image", .string, .required)
        
        try await schema.create()
    }
    
    func revert(on database: FluentKit.Database) async throws {
        try await database.schema("words").delete()
    }
}
