//
//  UserController.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 25/04/2025.
//
import Foundation

class UserController: ObservableObject {
    @Published var currentUser: User?
    @Published var errorMessage: String = ""

    // Método para autenticar usuário
    func login(email: String, password: String, completion: @escaping (User?) -> Void) {
        let url = URL(string: "https://api-app.xtracta.com/v1/user/authorize")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = "email=\(email)&password=\(password)"
        request.httpBody = bodyData.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Erro: \(error!.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else { return }
                
            // Decodificando a resposta do servidor
            if let userResponse = try? JSONDecoder().decode(UserResponse.self, from: data) {
                let newUser = User(userId: userResponse.userResponse.userId,
                                   userName: userResponse.userResponse.userName,
                                   apiKey: userResponse.userResponse.apiKey,
                                   password: password)
                self.currentUser = newUser
                completion(newUser)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}

// Estrutura para decodificar a resposta do servidor
struct UserResponse: Codable {
    var userResponse: UserDetail
    
    struct UserDetail: Codable {
        var status: Int
        var message: String
        var userId: String
        var userName: String
        var apiKey: String
    }
}
