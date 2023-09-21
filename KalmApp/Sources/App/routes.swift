import Fluent
import Vapor

func routes(_ app: Application) throws {
    try app.register(collection: UsersDataController())
    try app.register(collection: WordsController())
    try app.register(collection: CategoriesController())
    try app.register(collection: UsersController())
}
