//
//  User.swift
//  RestaurantFront
//
//  Created by Айгуль Манджиева on 20.09.2023.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let name: String
    let login: String
    let role: String
}

struct UserDTO: Codable {
    let login: String
    let password: String
}
