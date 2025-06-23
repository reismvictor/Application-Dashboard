//
//  APIService.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 15/04/2025.
//

import Foundation

// MARK: - APIService: Handles communication with the backend API
class APIService {
    
    static let shared = APIService()  // Singleton instance for easy access
    
    private init() {}
    
    // MARK: - User Login
    /// Perform login using email and password, then get the API key.
    /// - Parameters:
    ///   - email: The email address of the user.
    ///   - password: The password of the user.
    ///   - completion: A closure that will be executed once the login response is received.
    func loginUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        
        // Define URL and parameters for the login request
        guard let url = URL(string: "https://api-app.xtracta.com/v1/user/authorize") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let parameters = [
            "emailaddress": email,
            "password": password
        ]
        
        // Create the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        // Perform the network request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            // Parse the XML response for user data
            let userParser = XMLUserParser()
            if let user = userParser.parse(data: data) {
                completion(.success(user))
            } else {
                completion(.failure(NSError(domain: "Parsing error", code: 0, userInfo: nil)))
            }
        }
        task.resume()
    }
    
    // MARK: - Get Workflows
    /// Get all workflows assigned to the user by providing the API key.
    /// - Parameters:
    ///   - apiKey: The API key that was obtained from login.
    ///   - completion: A closure that will be executed once the workflows response is received.
    func getWorkflows(apiKey: String, completion: @escaping (Result<[WorkflowDetailModel], Error>) -> Void) {
        
        // Define URL and parameters for the workflows request
        guard let url = URL(string: "https://api-app.xtracta.com/v1/workflow") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let parameters = [
            "api_key": apiKey
        ]
        
        // Create the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        // Perform the network request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            // Parse the response for workflows data
            let workflowParser = XMLWorkflowParser()
            // The method call is updated to use the correct argument label
            let workflows = workflowParser.parse(workflows: data)
            
            // If there are no workflows, return an error
            if workflows.isEmpty {
                completion(.failure(NSError(domain: "No workflows found", code: 0, userInfo: nil)))
                return
            }
            
            completion(.success(workflows))
        }
        task.resume()
    }
}
