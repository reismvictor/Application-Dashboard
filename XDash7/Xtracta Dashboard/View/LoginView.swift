// LoginView.swift
// Xtracta Dashboard
//
// Created by Victor Reis on 21/04/2025.

import SwiftUI
import CoreData

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoading: Bool = false
    @State private var loginError: String? = nil

    @Environment(\.managedObjectContext) private var context

    private let workflowModel = WorkflowModel()

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(action: {
                login()
            }) {
                Text("Login")
                    .padding()
                    .background(isLoading ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(isLoading)
            
            if let loginError = loginError {
                Text(loginError)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
    }

    private func login() {
        isLoading = true
        loginError = nil

        guard !email.isEmpty, !password.isEmpty else {
            loginError = "Please enter both email and password."
            isLoading = false
            return
        }

        // Chama a API de login
        let url = URL(string: "https://api-app.xtracta.com/v1/user/authorize")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let params = ["email": email, "password": password]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            loginError = "Failed to encode data."
            isLoading = false
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.loginError = "Error: \(error.localizedDescription)"
                    self.isLoading = false
                    return
                }

                guard let data = data else {
                    self.loginError = "No data received."
                    self.isLoading = false
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(UserResponse.self, from: data)
                    if decoded.status == 200 {
                        // Salva o apiKey no UserDefaults
                        UserDefaults.standard.set(decoded.apiKey, forKey: "userApiKey")

                        // Fetch workflows após login bem-sucedido
                        self.workflowModel.fetchWorkflows(apiKey: decoded.apiKey, context: self.context)
                        self.isLoading = false
                    } else {
                        self.loginError = "Invalid credentials."
                        self.isLoading = false
                    }
                } catch {
                    self.loginError = "Failed to decode response."
                    self.isLoading = false
                }
            }
        }.resume()
    }
}
