//
//  DashboardController.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 21/04/2025.
//

import Foundation
import Combine
import CoreData

class DashboardController: ObservableObject {
    @Published var workflows: [Workflow] = []
    @Published var errorMessage: String?
    private var cancellables = Set<AnyCancellable>()

    func fetchWorkflows(apiKey: String) {
        guard let url = URL(string: "https://api-app.xtracta.com/v1/workflow") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "api_key")

        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: WorkflowResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.errorMessage = "Unable to fetch workflows: \(error.localizedDescription)"
                }
            }, receiveValue: { response in
                self.workflows = response.workflows

                // Fetch User from Core Data
                if let user = CoreDataManager.shared.fetchUser() {
                    // Iterate through the API workflows and save or update them in Core Data
                    response.workflows.forEach { wf in
                        CoreDataManager.shared.saveWorkflow(
                            id: wf.id,
                            name: wf.name,
                            groupId: wf.groupId,
                            groupName: wf.groupName,
                            user: user // Link to the existing user
                        )
                    }
                } else {
                    print("No user found in Core Data.  Please log in first.")
                    self.errorMessage = "No user found. Please log in."
                }

            })
            .store(in: &cancellables)
    }
}
