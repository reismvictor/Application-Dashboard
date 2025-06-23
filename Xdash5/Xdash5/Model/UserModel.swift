//
//  User.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 18/04/2025.
//

// UserModel.swift
// Model for authenticated user

import Foundation

struct UserModel: Codable {
    let userId: String
    let userName: String
    let apiKey: String
}
