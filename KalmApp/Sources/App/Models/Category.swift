import Vapor
import Fluent


final class Category: Model, Content {
    static var schema: String = "categories"
    
    @ID var id: UUID?
    @Field(key: "titleRussian") var titleRussian: String
    @Field(key: "titleKalmyk") var titleKalmyk: String
    @Field(key: "image") var image: String

    init(){}
    
}
