//
//  DashboardViewController.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 18/04/2025.
//

// DashboardViewController.swift
// Handles fetching workflows from API

import Foundation
import Combine
import SwiftUI

class DashboardViewController: ObservableObject {
    @AppStorage("userApiKey") var userApiKey: String = ""
    @Published var workflows: [WorkflowModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func fetchWorkflows() {
        guard let url = URL(string: "https://api-app.xtracta.com/v1/workflow") else {
            self.errorMessage = "Invalid URL"
            return
        }

        isLoading = true
        errorMessage = nil

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(userApiKey, forHTTPHeaderField: "X-API-KEY")

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }

            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received"
                }
                return
            }

            do {
                let decoded = try JSONDecoder().decode(WorkflowResponseWrapper.self, from: data)
                DispatchQueue.main.async {
                    self.workflows = decoded.workflowResponse
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to decode workflow response"
                }
            }
        }.resume()
    }
}

// MARK: - API Response Models
struct WorkflowResponseWrapper: Codable {
    let workflowResponse: [WorkflowModel]

    enum CodingKeys: String, CodingKey {
        case workflowResponse = "workflow_response"
    }
}
