//
//  UserModel.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 21/04/2025.
//

import Foundation

/// UserModel stores authenticated user information returned by the login API.
struct UserModel: Decodable {
    let status: Int
    let message: String
    let userId: String
    let userName: String
    let apiKey: String

    enum CodingKeys: String, CodingKey {
        case userResponse = "user_response"
    }

    enum UserKeys: String, CodingKey {
        case status
        case message
        case userId = "user_id"
        case userName = "user_name"
        case apiKey = "api_key"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let userContainer = try container.nestedContainer(keyedBy: UserKeys.self, forKey: .userResponse)
        
        status = try userContainer.decode(Int.self, forKey: .status)
        message = try userContainer.decode(String.self, forKey: .message)
        userId = try userContainer.decode(String.self, forKey: .userId)
        userName = try userContainer.decode(String.self, forKey: .userName)
        apiKey = try userContainer.decode(String.self, forKey: .apiKey)
    }
}
