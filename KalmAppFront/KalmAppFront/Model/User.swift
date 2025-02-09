import Foundation

struct User: Identifiable, Codable {
    let id: String
    let name: String
    let login: String
}

struct UserDTO: Codable {
    let login: String
    let password: String
}

struct UserRegister: Codable {
    let name: String
    let login: String
    let password: String
}
