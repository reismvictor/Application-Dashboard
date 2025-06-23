//
//  Workflow.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 25/04/2025.
//

import Foundation

// Modelo para armazenar informações sobre workflows
struct Workflow: Identifiable {
    var id: String { workflowId } // Conformidade com Identifiable
    var workflowId: String
    var workflowName: String
    var indexingQueueCount: Int
    var qaQueueCount: Int
    var rejectedQueueCount: Int
}


