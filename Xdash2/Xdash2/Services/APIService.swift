//
//  APIService.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 01/04/2025.
//

import Foundation

// MARK: - API Service for Fetching Documents
/// Handles network requests to retrieve document workflow data from the API.
class APIService {
    
    // API Endpoint URL (Replace with your actual API URL)
    private let apiURL = "https://api-app.xtracta.com/v1/tracking"
    
    /// Fetches document workflow data from the API and returns an array of `Document` objects.
    /// - Parameter completion: Completion handler returning `Result<[Document], Error>`.
    func fetchDocuments(completion: @escaping (Result<[Document], Error>) -> Void) {
        // 1. Create the URL
        guard let url = URL(string: apiURL) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        // 2. Create the URL request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // TODO: Add authentication headers if required
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("YOUR_API_KEY_HERE", forHTTPHeaderField: "Authorization") // Replace with actual API key
        
        // 3. Perform the network request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // 4. Handle network errors
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // 5. Ensure we have valid response data
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            // 6. Parse JSON data into `Document` objects
            if let documents = Document.from(jsonData: data) {
                completion(.success(documents))
            } else {
                completion(.failure(APIError.decodingFailed))
            }
        }.resume() // Start the network request
    }
}

// MARK: - API Error Handling
/// Defines possible API errors for better error management.
enum APIError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid API URL."
        case .noData:
            return "No data received from the server."
        case .decodingFailed:
            return "Failed to decode the JSON response."
        }
    }
}







//📝 Explanation of the Code
//✅ 1. APIService Class
//
//Handles network requests to fetch document data from https://api-app.xtracta.com/v1/tracking.
//Uses URLSession to make a GET request to the API.
//Passes the response data to Document.from(jsonData:) for JSON decoding.
//Calls a completion handler with either a success ([Document]) or an error.
//✅ 2. API Request Setup
//
//Creates a URLRequest with necessary headers (Accept: application/json, Authorization).
//Uses URLSession.shared.dataTask() to perform the request asynchronously.
//Calls .resume() to start the network request.
//✅ 3. Error Handling (APIError)
//
//Defines errors like invalidURL, noData, and decodingFailed.
//Provides readable error messages using LocalizedError.
