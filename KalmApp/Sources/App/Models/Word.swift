import Vapor
import Fluent


final class Word: Model, Content {
    static var schema: String = "words"
    
    @ID var id: UUID?
    @Field(key: "russian") var russian: String
    @Field(key: "kalmyk") var kalmyk: String
    @Field(key: "category") var category: String
    @Field(key: "image") var image: String
    
    init(){}

    internal init(id: UUID? = nil, russian: String, kalmyk: String, category: String, image: String) {
        self.id = id
        self.russian = russian
        self.kalmyk = kalmyk
        self.category = category
        self.image = image
    }
}
