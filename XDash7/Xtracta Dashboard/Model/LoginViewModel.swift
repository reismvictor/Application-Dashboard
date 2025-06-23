//
//  LoginViewModel.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 21/04/2025.
//

import Foundation
import CoreData

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var loginError: String? = nil
    @Published var isLoginSuccessful: Bool = false

    func login(context: NSManagedObjectContext) {
        guard !email.isEmpty, !password.isEmpty else {
            self.loginError = "Please enter both email and password."
            return
        }

        self.isLoading = true
        self.loginError = nil

        // Prepare URL and request
        guard let url = URL(string: "https://api-app.xtracta.com/v1/user/authorize") else {
            self.loginError = "Invalid URL."
            self.isLoading = false
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let params = [
            "email": email,
            "password": password
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            self.loginError = "Failed to encode login data."
            self.isLoading = false
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false

                if let error = error {
                    self.loginError = "Network error: \(error.localizedDescription)"
                    return
                }

                guard let data = data else {
                    self.loginError = "No data received from server."
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(UserResponse.self, from: data)

                    if decoded.userResponse.status == 200 {
                        // Save to Core Data
                        let newUser = UserEntity(context: context)
                        newUser.userId = decoded.userResponse.userId
                        newUser.userName = decoded.userResponse.userName
                        newUser.apiKey = decoded.userResponse.apiKey

                        try context.save()
                        self.isLoginSuccessful = true
                    } else {
                        self.loginError = decoded.userResponse.message
                    }
                } catch {
                    self.loginError = "Failed to parse response: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}
