//
//  LoginController.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 21/04/2025.
//

import Foundation
import Combine

class LoginController: ObservableObject {
    @Published var user: UserModel?
    @Published var errorMessage: String?
    private var cancellables = Set<AnyCancellable>()

    func login(email: String, password: String) {
        guard let url = URL(string: "https://api-app.xtracta.com/v1/user/authorize") else { return }
        let params = ["email": email, "password": password]
        guard let body = try? JSONSerialization.data(withJSONObject: params) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body

        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: UserModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.errorMessage = "Login failed: \(error.localizedDescription)"
                }
            }, receiveValue: { user in
                self.user = user

                // Save to Core Data
                CoreDataManager.shared.saveUser(
                    id: user.userId,
                    name: user.userName,
                    apiKey: user.apiKey
                )
            })
            .store(in: &cancellables)
    }
}
