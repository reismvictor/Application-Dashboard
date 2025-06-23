//
//  Login.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 18/04/2025.
//

// LoginView.swift
// Login screen UI

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewController()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image("Xtracta_Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)

                TextField("Email", text: $viewModel.email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)

                SecureField("Password", text: $viewModel.password)
                    .textContentType(.password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)

                if viewModel.isLoading {
                    ProgressView()
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                Button(action: {
                    viewModel.login()
                }) {
                    Text("Login")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Login")
            .fullScreenCover(isPresented: $viewModel.isLoggedIn) {
            DashboardView() // Next step
            }
        }
    }
}
