//
//  DashboardView.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 18/04/2025.
//

// DashboardView.swift
// Shows list of workflows with document queues

// DashboardView.swift
// Main dashboard screen showing workflows and document queues

import SwiftUI

struct DashboardView: View {
    @AppStorage("userApiKey") var userApiKey: String = ""
    @StateObject private var controller = DashboardViewController()
    @EnvironmentObject var session: SessionManager

    var body: some View {
        NavigationView {
            VStack {
                // Header with app title and logout button
                HStack {
                    Text("Xtracta Dashboard")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Button("Logout") {
                        session.logOut()
                    }
                    .foregroundColor(.red)
                }
                .padding()

                // Content section
                if controller.isLoading {
                    Spacer()
                    ProgressView("Loading workflows...")
                        .padding()
                    Spacer()
                } else if let error = controller.errorMessage {
                    Spacer()
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                    Spacer()
                } else {
                    List {
                        ForEach(controller.workflows) { workflow in
                            NavigationLink(destination: WorkflowDetailView(workflow: workflow)) {
                                WorkflowCardView(workflow: workflow)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .refreshable {
                        controller.fetchWorkflows(apiKey: userApiKey)
                    }
                }
            }
            .onAppear {
                controller.fetchWorkflows(apiKey: userApiKey)
            }
            .navigationBarHidden(true)
        }
    }
}
