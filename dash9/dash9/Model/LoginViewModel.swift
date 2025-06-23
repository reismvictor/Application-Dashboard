//
//  LoginViewModel.swift
//  XtractaDashboard
//
//  Created by Victor Reis on 21/04/2025.
//

// Controller/LoginViewModel.swift
import Foundation
import Combine

/// ViewModel for LoginView
final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isLoggedIn: Bool = false

    private var cancellables = Set<AnyCancellable>()

    /// Calls the login controller to perform authentication
    func login() {
        errorMessage = nil
        isLoading = true
        LoginController.shared.login(email: email, password: password) { [weak self] (result: Result<Void, Error>) in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success:
                    self?.isLoggedIn = true
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
