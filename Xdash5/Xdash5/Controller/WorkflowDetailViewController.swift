//
//  WorkflowDetailViewController.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 18/04/2025.
//

// WorkflowDetailViewController.swift
// Controller for fetching documents from the API

import Foundation

class WorkflowDetailViewController: ObservableObject {
    @Published var indexingDocs: [DocumentModel] = []
    @Published var qaDocs: [DocumentModel] = []
    @Published var rejectedDocs: [DocumentModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchDocuments(apiKey: String, workflowID: String) {
        isLoading = true
        errorMessage = nil

        // Chamadas paralelas para os 3 tipos de status
        let statuses = ["indexing", "qa", "reject"]
        let group = DispatchGroup()

        var tempIndexing: [DocumentModel] = []
        var tempQA: [DocumentModel] = []
        var tempRejected: [DocumentModel] = []

        for status in statuses {
            group.enter()
            fetchDocumentsForStatus(apiKey: apiKey, workflowID: workflowID, status: status) { docs in
                DispatchQueue.main.async {
                    switch status {
                    case "indexing": tempIndexing = docs
                    case "qa": tempQA = docs
                    case "reject": tempRejected = docs
                    default: break
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            self.indexingDocs = tempIndexing
            self.qaDocs = tempQA
            self.rejectedDocs = tempRejected
            self.isLoading = false
        }
    }

    private func fetchDocumentsForStatus(apiKey: String, workflowID: String, status: String, completion: @escaping ([DocumentModel]) -> Void) {
        guard let url = URL(string: "https://api-app.xtracta.com/v1/tracking") else {
            completion([])
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let params = "apiKey=\(apiKey)&WorkflowID=\(workflowID)&status=\(status)"
        request.httpBody = params.data(using: .utf8)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let documentsResp = json["documents_response"] as? [String: Any],
                  let docs = documentsResp["document"] as? [[String: Any]] else {
                completion([])
                return
            }

            let documentModels = docs.map { DocumentModel(from: $0) }
            completion(documentModels)
        }.resume()
    }
}
