import Fluent
import Vapor

final class User: Content, Model {
    static let schema: String = "users"
    @ID var id: UUID?
    @Field(key: "name") var name: String
    @Field(key: "login") var login: String
    @Field(key: "password") var password: String
    
    final class Public: Content {
        var id: UUID?
        var name: String
        var login: String
        
        init(id: UUID? = nil, name: String, login: String) {
            self.id = id
            self.name = name
            self.login = login
        }
    }
}

extension User: ModelAuthenticatable {
    static var usernameKey = \User.$login
    static var passwordHashKey = \User.$password
    
    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.password)
    }
}

extension User {
    func convertToPublic() -> User.Public {
        let pub = User.Public(id: self.id, name: self.name, login: self.login)
        return pub
    }
}

extension User: @unchecked Sendable {}
