import Vapor
import Fluent


final class UserData: Model, Content {
    static var schema: String = "data"
    
    @ID var id: UUID?
    @Field(key: "userID") var userID: String
    @Field(key: "categoryID") var categoryID: String
    @Field(key: "name") var name: String
    @Field(key: "correctAnswers") var correctAnswers: Int
    @Field(key: "allAnswers") var allAnswers: Int
    init(){}
    
}
