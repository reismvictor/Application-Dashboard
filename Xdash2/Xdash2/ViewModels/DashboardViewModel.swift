//
//  DashboardViewModel.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 01/04/2025.
//

import Foundation
import Combine

// MARK: - ViewModel for Fetching and Managing API Data
/// Fetches document data from the API and updates the UI.
class DashboardViewModel: ObservableObject {
    
    // Published list of documents (triggers UI updates when changed)
    @Published var documents: [Document] = []
    
    // Stores any API error messages
    @Published var errorMessage: String? = nil
    
    // API service instance
    private let apiService = APIService()
    
    /// Fetches documents from the API and updates the UI.
    func fetchDocuments() {
        apiService.fetchDocuments { [weak self] result in
            DispatchQueue.main.async { // Ensure UI updates happen on the main thread
                switch result {
                case .success(let documents):
                    self?.documents = documents
                    self?.errorMessage = nil // Clear previous errors
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}






//📝 Explanation of the Code
//✅ 1. DashboardViewModel (ObservableObject)
//
//Manages document data and exposes it to SwiftUI views.
//Uses @Published var documents to trigger UI updates automatically.
//✅ 2. fetchDocuments() Method
//
//Calls APIService.fetchDocuments().
//Updates documents if successful, or sets errorMessage if there’s an error.
//Runs UI updates on the main thread (DispatchQueue.main.async).
