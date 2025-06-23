//
//  LoginViewController.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 18/04/2025.
//

// LoginViewController.swift
// Handles login logic and API calls

import Foundation
import Combine

class LoginViewController: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isLoggedIn: Bool = false

    // AppStorage variables to persist data
    @AppStorage("userApiKey") var userApiKey: String = ""
    @AppStorage("userId") var userId: String = ""
    @AppStorage("userName") var userName: String = ""

    // Login function
    func login() {
        guard let url = URL(string: "https://api-app.xtracta.com/v1/user/authorize") else {
            self.errorMessage = "Invalid URL"
            return
        }

        isLoading = true
        errorMessage = nil

        let body: [String: Any] = [
            "email": email,
            "password": password
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
            self.errorMessage = "Invalid request data"
            self.isLoading = false
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }

            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received"
                }
                return
            }

            do {
                let decoded = try JSONDecoder().decode(UserResponseWrapper.self, from: data)
                let user = decoded.userResponse

                if user.status == 200 {
                    DispatchQueue.main.async {
                        self.userApiKey = user.apiKey
                        self.userId = user.userId
                        self.userName = user.userName
                        self.isLoggedIn = true
                    }
                } else {
                    DispatchQueue.main.async {
                        self.errorMessage = "Login failed"
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to decode response"
                }
            }
        }.resume()
    }
}

// MARK: - API Response Models
struct UserResponseWrapper: Codable {
    let userResponse: UserResponse

    enum CodingKeys: String, CodingKey {
        case userResponse = "user_response"
    }
}

struct UserResponse: Codable {
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
