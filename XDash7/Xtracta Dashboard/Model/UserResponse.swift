//
//  UserResponse.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 21/04/2025.
//
import Foundation

// MARK: - Top-level Response Object
struct UserResponse: Codable {
    let userResponse: UserAPIData

    enum CodingKeys: String, CodingKey {
        case userResponse = "user_response"
    }
}

// MARK: - User API Inner Response
struct UserAPIData: Codable {
    let status: Int
    let message: String
    let userId: String
    let userName: String
    let apiKey: String

    enum CodingKeys: String, CodingKey {
        case status
        case message
        case userId = "user_id"
        case userName = "user_name"
        case apiKey = "api_key"
    }
}

