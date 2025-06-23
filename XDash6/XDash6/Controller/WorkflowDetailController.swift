//
//  WorkflowDetailController.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 21/04/2025.
//

import Foundation
import CoreData
import Combine

class WorkflowDetailController: ObservableObject {
    @Published var indexingDocuments: [Document] = []
    @Published var qaDocuments: [Document] = []
    @Published var rejectedDocuments: [Document] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    private var cancellables = Set<AnyCancellable>()

    func fetchAllQueues(apiKey: String, workflowID: String) {
        isLoading = true
        errorMessage = nil

        let group = DispatchGroup()

        var indexing: [Document] = []
        var qa: [Document] = []
        var rejected: [Document] = []
        var fetchError: String?

        // Fetch Indexing
        group.enter()
        fetchDocuments(apiKey: apiKey, workflowID: workflowID, status: "indexing") { result in
            switch result {
            case .success(let docs): indexing = docs
            case .failure(let error): fetchError = error.localizedDescription
            }
            group.leave()
        }

        // Fetch QA
        group.enter()
        fetchDocuments(apiKey: apiKey, workflowID: workflowID, status: "qa") { result in
            switch result {
            case .success(let docs): qa = docs
            case .failure(let error): fetchError = error.localizedDescription
            }
            group.leave()
        }

        // Fetch Rejected
        group.enter()
        fetchDocuments(apiKey: apiKey, workflowID: workflowID, status: "reject") { result in
            switch result {
            case .success(let docs): rejected = docs
            case .failure(let error): fetchError = error.localizedDescription
            }
            group.leave()
        }

        group.notify(queue: .main) {
            self.isLoading = false
            if let err = fetchError {
                self.errorMessage = err
                return
            }

            self.indexingDocuments = indexing
            self.qaDocuments = qa
            self.rejectedDocuments = rejected

            // Persist documents to Core Data
            if let workflowEntity = CoreDataManager.shared.fetchWorkflows().first(where: { $0.id == workflowID }) {
                indexing.forEach { doc in
                    CoreDataManager.shared.saveDocument(
                        id: doc.id,
                        fileName: doc.fileName,
                        pages: doc.numberOfPages,
                        timeReceived: doc.timeReceived,
                        minutesInQueue: doc.minutesInQueue,
                        status: "indexing",
                        workflow: workflowEntity
                    )
                }

                qa.forEach { doc in
                    CoreDataManager.shared.saveDocument(
                        id: doc.id,
                        fileName: doc.fileName,
                        pages: doc.numberOfPages,
                        timeReceived: doc.timeReceived,
                        minutesInQueue: doc.minutesInQueue,
                        status: "qa",
                        workflow: workflowEntity
                    )
                }

                rejected.forEach { doc in
                    CoreDataManager.shared.saveDocument(
                        id: doc.id,
                        fileName: doc.fileName,
                        pages: doc.numberOfPages,
                        timeReceived: doc.timeReceived,
                        minutesInQueue: doc.minutesInQueue,
                        status: "reject",
                        workflow: workflowEntity
                    )
                }
            }
        }
    }

    private func fetchDocuments(apiKey: String, workflowID: String, status: String, completion: @escaping (Result<[Document], Error>) -> Void) {
         guard let url = URL(string: "https://api-app.xtracta.com/v1/document?workflow_id=\(workflowID)&status=\(status)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "api_key")

        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: DocumentsResponseRoot.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    completion(.failure(error))
                }
            }, receiveValue: { rootResponse in
                let documents = rootResponse.documentsResponse.document.map { rawDoc in
                    Document(
                        id: rawDoc.documentID,
                        fileName: rawDoc.documentURL, // Adjust here:  documentURL might be a full URL
                        numberOfPages: Int(rawDoc.numberOfPages) ?? 0,
                        timeReceived: Date(), // API should return a date string
                        minutesInQueue: 0      // Adjust as needed
                    )
                }
                completion(.success(documents))
            })
            .store(in: &cancellables)
    }
}
