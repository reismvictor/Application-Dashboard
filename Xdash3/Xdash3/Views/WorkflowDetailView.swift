//
//  WorkflowDetailView.swift
//  Xtracta Dashboard3
//
//  Created by Victor Reis on 01/04/2025.
//

import SwiftUI

struct WorkflowDetailView: View {
    var documents: [Document]  // Array of documents for the selected workflow
    
    var body: some View {
        VStack {
            // Detailed view of documents
            List(documents) { document in
                VStack(alignment: .leading) {
                    Text("Document ID: \(document.id)")
                        .font(.headline)
                    Text("Status: \(document.status)")
                    Text("Received: \(formattedDate(document.receivedDate))")
                    Text("Time in system: \(timeElapsed(from: document.receivedDate))")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 5))
                .padding(.vertical, 5)
            }
        }
        .navigationTitle("Workflow Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Format the received date into a readable string
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter.string(from: date)
    }
    
    // Calculate the time difference between the received date and now
    func timeElapsed(from date: Date) -> String {
        let currentTime = Date()
        let elapsed = currentTime.timeIntervalSince(date)
        let minutes = Int(elapsed) / 60
        let hours = minutes / 60
        return "\(hours) hours and \(minutes % 60) minutes"
    }
}

struct WorkflowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkflowDetailView(documents: [
            Document(id: "1", status: "Indexing", receivedDate: Date()),
            Document(id: "2", status: "Rejected", receivedDate: Date().addingTimeInterval(-7200))
        ])
    }
}
