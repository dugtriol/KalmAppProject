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
    
    func getWords() async throws -> [Word] {
        guard let url = URL(string: "\(localhost)\(APIMethod.auth.rawValue)") else {
            throw NetworkError.badURL
        }
        
        let userResponse = try await URLSession.shared.data(for: URLRequest(url: url))
        let userData = userResponse.0
        
        let decoder = JSONDecoder()
        let words = try decoder.decode([Word].self, from: userData)
        return words
    }
    
}

enum APIMethod: String {
    case auth = "/words/"
}

enum NetworkError: Error {
    case badURL
}
