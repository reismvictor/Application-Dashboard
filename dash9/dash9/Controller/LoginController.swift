// Controller/LoginController.swift
import Foundation
import CoreData

/// Handles login logic and Core Data user saving
final class LoginController {
    static let shared = LoginController()
    private let context = PersistenceController.shared.container.viewContext

    private init() {}

    /// Performs login API call and saves user data to Core Data
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "https://api-app.xtracta.com/v1/user/authorize") else {
            completion(.failure(LoginError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body: [String: Any] = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(LoginError.noData))
                return
            }

            do {
                let apiResponse = try JSONDecoder().decode(UserAPIResponse.self, from: data)
                let userResponse = apiResponse.user_response
                guard userResponse.status == 200 else {
                    completion(.failure(LoginError.invalidCredentials))
                    return
                }
                // Save user to Core Data
                try self?.saveUser(userResponse: userResponse, email: email, password: password)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    /// Saves user data to Core Data
    private func saveUser(userResponse: UserResponse, email: String, password: String) throws {
        // Remove previous users (if any)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try context.execute(deleteRequest)

        // Create new user
        let user = User(context: context)
        user.userId = userResponse.user_id
        user.userName = userResponse.user_name
        user.userApiKey = userResponse.api_key
        user.email = email
        user.password = password

        try context.save()
    }

    // MARK: - Error Types

    enum LoginError: LocalizedError {
        case invalidURL
        case noData
        case invalidCredentials

        var errorDescription: String? {
            switch self {
            case .invalidURL: return "Invalid URL."
            case .noData: return "No data received from server."
            case .invalidCredentials: return "Invalid email or password."
            }
        }
    }
}

// MARK: - Decodable structs for API response

struct UserAPIResponse: Decodable {
    let user_response: UserResponse
}

struct UserResponse: Decodable {
    let status: Int
    let message: String
    let user_id: String
    let user_name: String
    let api_key: String
}
