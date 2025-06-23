//
//  WorkflowDetailView.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 18/04/2025.
//

/// WorkflowDetailView.swift
// View for showing documents in tabs by queue

import SwiftUI

struct WorkflowDetailView: View {
    var workflow: WorkflowModel
    @AppStorage("userApiKey") var userApiKey: String = ""
    @StateObject private var controller = WorkflowDetailViewController()
    @State private var selectedTab = 0

    var body: some View {
        VStack {
            Picker("Queue", selection: $selectedTab) {
                Text("Indexing").tag(0)
                Text("QA").tag(1)
                Text("Rejected").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            if controller.isLoading {
                ProgressView("Loading documents...")
                    .padding()
            } else {
                List {
                    ForEach(currentDocuments) { doc in
                        VStack(alignment: .leading) {
                            Text("Document ID: \(doc.id)")
                                .font(.headline)
                            Text("Filename: \(doc.fileName)")
                            Text("Pages: \(doc.numberOfPages)")
                            Text("Time in queue: \(doc.minutesSinceReceived) minutes")
                        }
                        .padding(.vertical, 4)
                    }
                }
                .listStyle(PlainListStyle())
                .refreshable {
                    controller.fetchDocuments(apiKey: userApiKey, workflowID: workflow.workflowID)
                }
            }
        }
        .navigationTitle(workflow.workflowName)
        .onAppear {
            controller.fetchDocuments(apiKey: userApiKey, workflowID: workflow.workflowID)
        }
    }

    var currentDocuments: [DocumentModel] {
        switch selectedTab {
        case 0: return controller.indexingDocs
        case 1: return controller.qaDocs
        case 2: return controller.rejectedDocs
        default: return []
        }
    }
}
