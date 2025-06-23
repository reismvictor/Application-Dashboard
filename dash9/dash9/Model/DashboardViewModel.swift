//
//  DashboardViewModel.swift
//  XtractaDashboard
//
//  Created by Victor Reis on 21/04/2025.
//

// Controller/DashboardViewModel.swift
import Foundation
import CoreData

/// ViewModel for DashboardView
final class DashboardViewModel: ObservableObject {
    @Published var workflows: [Workflow] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let controller = DashboardController.shared
    
    func loadWorkflows() {
        isLoading = true
        errorMessage = nil
        controller.fetchWorkflows { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let workflows):
                    self?.workflows = workflows
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func refresh() {
        loadWorkflows()
    }
}
