//
//  DashboardView.swift
//  Xtracta Dashboard3
//
//  Created by Victor Reis on 01/04/2025.
//

import SwiftUI

struct DashboardView: View {
    // Sample data for workflows
    let workflows = [
        WorkflowModel(name: "Workflow 1", indexingCount: 120, rejectedCount: 15, qaCount: 40, documents: [
            Document(id: "1", status: "Indexing", receivedDate: Date()),
            Document(id: "2", status: "Rejected", receivedDate: Date().addingTimeInterval(-7200))
        ]),
        WorkflowModel(name: "Workflow 2", indexingCount: 200, rejectedCount: 30, qaCount: 100, documents: [
            Document(id: "3", status: "QA", receivedDate: Date().addingTimeInterval(-86400)),
            Document(id: "4", status: "Indexing", receivedDate: Date().addingTimeInterval(-18000))
        ])
    ]
    
    var body: some View {
        VStack {
            // Title
            Text("Dashboard")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 40)
            
            // Scrollable view for workflow cards
            ScrollView {
                VStack(spacing: 25) {
                    ForEach(workflows, id: \.name) { workflow in
                        WorkflowCard(workflow: workflow)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)
            }
            
            // Help Button at the bottom
            Spacer()
            
            HStack {
                Spacer()
                NavigationLink(destination: HelpView()) {
                    Image(systemName: "questionmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.blue)
                        .padding(.bottom, 30)
                }
            }
        }
        .background(Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)) // Subtle background color
        .navigationTitle("Dashboard")
        .navigationBarItems(trailing: settingsButton) // Settings icon
    }
    
    // Settings Icon in the top right
    private var settingsButton: some View {
        NavigationLink(destination: SettingsView()) {
            Image(systemName: "gearshape.fill")
                .font(.title)
                .foregroundColor(.blue)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
