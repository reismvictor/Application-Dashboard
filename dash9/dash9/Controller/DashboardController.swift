//
//  DashboardController.swift
//  XtractaDashboard
//
//  Created by Victor Reis on 21/04/2025.
//

// Controller/DashboardController.swift
import Foundation
import CoreData

/// Handles fetching workflows from API and saving to Core Data
final class DashboardController {
    static let shared = DashboardController()
    private let context = PersistenceController.shared.container.viewContext

    private init() {}

    /// Fetches workflows from API using the saved userApiKey
    func fetchWorkflows(completion: @escaping (Result<[Workflow], Error>) -> Void) {
        guard let user = fetchCurrentUser() else {
            completion(.failure(DashboardError.noUser))
            return
        }
        guard let url = URL(string: "https://api-app.xtracta.com/v1/workflow") else {
            completion(.failure(DashboardError.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(user.userApiKey, forHTTPHeaderField: "apiKey")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(DashboardError.noData))
                return
            }
            do {
                let apiResponse = try JSONDecoder().decode(WorkflowAPIResponse.self, from: data)
                let workflows = try self?.saveWorkflows(apiResponse: apiResponse, user: user)
                completion(.success(workflows ?? []))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    /// Returns the current logged-in user from Core Data
    private func fetchCurrentUser() -> User? {
        let request = NSFetchRequest<User>(entityName: "User")
        request.fetchLimit = 1
        return (try? context.fetch(request))?.first
    }
    
    /// Saves workflows to Core Data and returns them
    private func saveWorkflows(apiResponse: WorkflowAPIResponse, user: User) throws -> [Workflow] {
        // Remove previous workflows
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Workflow.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try context.execute(deleteRequest)
        
        // Parse and save new workflows
        var workflows: [Workflow] = []
        for apiWorkflow in apiResponse.workflows {
            let workflow = Workflow(context: context)
            workflow.workflowId = apiWorkflow.workflow_id
            workflow.workflowName = apiWorkflow.workflow_name
            workflow.indexingCount = Int32(apiWorkflow.indexing_count)
            workflow.qaCount = Int32(apiWorkflow.qa_count)
            workflow.rejectedCount = Int32(apiWorkflow.rejected_count)
            workflow.user = user
            workflows.append(workflow)
        }
        try context.save()
        return workflows
    }
    
    enum DashboardError: LocalizedError {
        case noUser
        case invalidURL
        case noData
        
        var errorDescription: String? {
            switch self {
            case .noUser: return "No logged-in user found."
            case .invalidURL: return "Invalid URL."
            case .noData: return "No data received from server."
            }
        }
    }
}

/// Decodable structs for API response
struct WorkflowAPIResponse: Decodable {
    let workflows: [WorkflowResponse]
}

struct WorkflowResponse: Decodable {
    let workflow_id: String
    let workflow_name: String
    let indexing_count: Int
    let qa_count: Int
    let rejected_count: Int
}
