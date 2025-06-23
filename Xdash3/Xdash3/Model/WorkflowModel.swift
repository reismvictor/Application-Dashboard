//
//  WorkflowModel.swift
//  Xtracta Dashboard3
//
//  Created by Victor Reis on 01/04/2025.
//

// WorkflowModel.swift
import Foundation

struct WorkflowModel: Identifiable {
    var id = UUID()
    var name: String
    var indexingCount: Int
    var rejectedCount: Int
    var qaCount: Int
    var documents: [Document] // Array of documents in this workflow
}

