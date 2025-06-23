//
//  LoginView.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 15/04/2025.
//

import SwiftUI

// MARK: - LoginView: A view for the user to input email and password for authentication
struct LoginView: View {
    
    // MARK: - Properties
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String? = nil
    @State private var isLoggedIn: Bool = false
    @State private var isLoading: Bool = false
    
    var body: some View {
        VStack {
            // Xtracta Logo
            Image("Xtracta_Logo")  // Add the logo image in Assets
                .resizable()
                .scaledToFit()
                .frame(width: 500, height: 100)
                .padding(.top, 150)
                .padding(50)
            
            // Email Input Field
            TextField("Email", text: $email)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            // Password Input Field
            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)
            
            // Error Message Display
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.top, 10)
            }
            
            // Login Button
            Button(action: {
                loginUser()
            }) {
                Text(isLoading ? "Logging In..." : "Log In")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(isLoading ? Color.gray : Color.blue)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            .disabled(isLoading)
            
            Spacer()
        }
        .padding()
    }
    
    // MARK: - Login Function
    private func loginUser() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in both fields."
            return
        }
        
        // Clear previous errors
        errorMessage = nil
        isLoading = true
        
        // Call the API service to log in
        APIService.shared.loginUser(email: email, password: password) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let user):
                    // Handle successful login (store user data, navigate to next screen, etc.)
                    self.isLoggedIn = true
                    print("Logged in successfully: \(user.userName), API Key: \(user.apiKey)")
                    // You can transition to the next screen or save the user info here
                    
                case .failure(let error):
                    self.errorMessage = "Login failed: \(error.localizedDescription)"
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
