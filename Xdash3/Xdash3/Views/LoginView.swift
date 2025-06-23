//
//  LoginView.swift
//  Xtracta Dashboard3
//
//  Created by Victor Reis on 01/04/2025.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            VStack {
                Spacer() // Pushes content towards the center
                
                // Xtracta Logo
                Image("xtractalogo") // Ensure this asset is added to your Xcode project
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300, alignment: .center)
                    .padding(.top, 60)
                
                // Email Field
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.headline)
                        .padding(.leading, 40)
                    TextField("Enter your email", text: $email)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 5)
                        .shadow(radius: 5)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
                .padding(.top, 20)
                
                // Password Field
                VStack(alignment: .leading) {
                    Text("Password")
                        .font(.headline)
                        .padding(.leading, 40)
                    SecureField("Enter your password", text: $password)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 20)
                        .shadow(radius: 5)
                }
                .padding(.top, 20)
                
                // Error Message
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.top, 10)
                }
                
                // Login Button
                Button(action: loginUser) {
                    HStack {
                        Image(systemName: "arrow.right.circle.fill") // Login icon
                            .foregroundColor(.white)
                        Text("Log In")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 300)
                    .shadow(radius: 5)
                }

                Spacer() // Pushes content towards the center of the screen
            }

            .background(
                // Navigation Link to Dashboard
                NavigationLink(destination: DashboardView(), isActive: $isLoggedIn) {
                    EmptyView()
                }
            )
        }
    }

    // Login button action
    func loginUser() {
        // Add your login logic here
        if email.isEmpty || password.isEmpty {
            errorMessage = "Please fill in both fields."
        } else {
            errorMessage = nil
            // Simulate a successful login for now
            isLoggedIn = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
