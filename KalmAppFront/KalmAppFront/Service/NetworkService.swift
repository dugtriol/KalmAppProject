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
}

enum APIMethod: String {
    case words = "/words/"
    case categories = "/categories/"
}

enum NetworkError: Error {
    case badURL
}
