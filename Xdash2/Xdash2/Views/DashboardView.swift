//
//  DocumentView.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 01/04/2025.
//

import SwiftUI

// MARK: - Dashboard View
/// Displays a list of documents retrieved from the API.
struct DashboardView: View {
    
    @StateObject private var viewModel = DashboardViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                }
                
                List(viewModel.documents) { document in
                    NavigationLink(destination: DocumentDetailView(document: document)) {
                        VStack(alignment: .leading) {
                            Text("Document ID: \(document.documentID)")
                                .font(.headline)
                            Text("Status: \(document.documentStatus)")
                                .foregroundColor(document.documentStatus == "OK" ? .green : .red)
                            Text("Received: \(document.dateReceived)")
                                .font(.caption)
                            if let fileName = document.fileName {
                                Text("File Name: \(fileName)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(5)
                    }
                }
            }
            .navigationTitle("Document Dashboard")
            .toolbar {
                Button(action: {
                    viewModel.fetchDocuments()
                }) {
                    Image(systemName: "arrow.clockwise")
                }
            }
            .onAppear {
                viewModel.fetchDocuments()
            }
        }
    }
}



//📝 Explanation of the Code
//✅ 1. @StateObject var viewModel = DashboardViewModel()
//
//Observes DashboardViewModel to update the UI when data changes.
//✅ 2. Displays Document List
//
//Shows Document ID, Status, Date Received, and File Name.
//Color codes status:
//Green ✅ for "OK".
//Red ❌ for other statuses.
//✅ 3. Error Handling
//
//If viewModel.errorMessage is not nil, it displays an error message in red.
//✅ 4. Refresh Button
//
//Manually refreshes the document list (fetchDocuments()).
//✅ 5. onAppear Fetches Data
//
//Calls fetchDocuments() when the screen loads.
