//
//  LoginView.swift
//  XtractaDashboard
//
//  Created by Victor Reis on 21/04/2025.
//

// View/LoginView.swift
import SwiftUI

/// Login screen for Xtracta Dashboard
struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Text("Xtracta Dashboard")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if viewModel.isLoading {
                    ProgressView()
                }
                
                Button(action: {
                    viewModel.login()
                }) {
                    Text("Login")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(viewModel.isLoading || viewModel.email.isEmpty || viewModel.password.isEmpty)
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.top, 8)
                }
                
                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
            .background(
                NavigationLink(
                    destination: DashboardView()
                        .navigationBarBackButtonHidden(true),
                    isActive: $viewModel.isLoggedIn
                ) { EmptyView() }
            )
        }
    }
}
