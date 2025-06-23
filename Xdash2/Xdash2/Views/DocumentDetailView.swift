//
//  DocumentDetailView.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 01/04/2025.
//

import SwiftUI

// MARK: - Document Detail View
/// Displays detailed information about a selected document.
struct DocumentDetailView: View {
    
    let document: Document // Selected document
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Document Details")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 10)
            
            Text("📄 **Document ID:** \(document.documentID)")
            Text("📌 **Status:** \(document.documentStatus)")
                .foregroundColor(document.documentStatus == "OK" ? .green : .red)
            Text("📅 **Received Date:** \(document.dateReceived)")
            if let fileName = document.fileName {
                Text("📂 **File Name:** \(fileName)")
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Document Details")
    }
}
