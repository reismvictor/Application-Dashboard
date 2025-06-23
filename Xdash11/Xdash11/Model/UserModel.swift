//
//  User.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 25/04/2025.
//

// Model/UserModel.swift

import Foundation

/// Represents a temporary user session (not persisted).
struct UserModel: Codable {
    let userID: String
    let userName: String
    let apiKey: String
    let password: String
}



