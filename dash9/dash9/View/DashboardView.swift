//
//  DashboardView.swift
//  XtractaDashboard
//
//  Created by Victor Reis on 21/04/2025.
//

// View/DashboardView.swift
import SwiftUI

/// Dashboard screen displaying all workflows and their queues
struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Workflows")
                        .font(.title)
                        .bold()
                    Spacer()
                    Button(action: {
                        viewModel.refresh()
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.title2)
                    }
                    .accessibilityLabel("Refresh Workflows")
                }
                .padding(.horizontal)
                .padding(.top)
                
                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else if let error = viewModel.errorMessage {
                    Spacer()
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()
                } else if viewModel.workflows.isEmpty {
                    Spacer()
                    Text("No workflows found.")
                        .foregroundColor(.gray)
                    Spacer()
                } else {
                    List(viewModel.workflows, id: \.workflowId) { workflow in
                        NavigationLink(destination: WorkflowDetailView(workflow: workflow)) {
                            WorkflowCellView(workflow: workflow)
                        }
                        .listRowBackground(Color(UIColor.secondarySystemBackground))
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .onAppear { viewModel.loadWorkflows() }
            .navigationBarHidden(true)
        }
    }
}
