//
//  NetworkService.swift
//  KalmAppFront
//
//  Created by Айгуль Манджиева on 17.09.2023.
//

import Foundation

class NetworkService {
    static var shared = NetworkService();
    private init() {}
    private let localhost = "http://127.0.0.1:8080"
    
    func getWordsByCategory(id: String) async throws -> [Word] {
        guard let url = URL(string: "\(localhost)\(APIMethod.words.rawValue)\(id)") else {
            throw NetworkError.badURL
        }
        
        let userResponse = try await URLSession.shared.data(for: URLRequest(url: url))
        let userData = userResponse.0
        
        let decoder = JSONDecoder()
        let words = try decoder.decode([Word].self, from: userData)
        return words
    }
    
    func getCategories() async throws -> [Category] {
        guard let url = URL(string: "\(localhost)\(APIMethod.categories.rawValue)") else {
            throw NetworkError.badURL
        }
        
        let userResponse = try await URLSession.shared.data(for: URLRequest(url: url))
        let userData = userResponse.0
        
        let decoder = JSONDecoder()
        let categories = try decoder.decode([Category].self, from: userData)
        return categories
    }
    
    func auth(login: String, password: String) async throws -> User {
        let dto = UserDTO(login: login, password: password)
        guard let url = URL(string: "\(localhost)\(APIMethod.auth.rawValue)") else {
            throw NetworkError.badURL
        }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let encoder = JSONEncoder()
        let data = try encoder.encode(dto)
        request.httpBody = data
        let userResponse = try await URLSession.shared.data(for: request)
        let userData = userResponse.0
        let decoder = JSONDecoder()
        let user = try decoder.decode(User.self, from: userData)
        return user
    }
    
    func registerUser(name: String, login: String, password: String) async throws -> User {
        let dto = UserRegister(name: name, login: login, password: password)
        guard let url = URL(string: "\(localhost)\(APIMethod.register.rawValue)") else {
            throw NetworkError.badURL
        }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let encoder = JSONEncoder()
        let data = try encoder.encode(dto)
        request.httpBody = data
        let userResponse = try await URLSession.shared.data(for: request)
        let userData = userResponse.0
        let decoder = JSONDecoder()
        let user = try decoder.decode(User.self, from: userData)
        return user
    }
}

enum APIMethod: String {
    case words = "/words/"
    case categories = "/categories/"
    case auth = "/users/auth"
    case register = "/users"
}

enum NetworkError: Error {
    case badURL
}
