//
//  WorkflowModels.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 18/04/2025.
//

// WorkflowModel.swift
// Represents a Workflow and queue counts

import Foundation

struct WorkflowModel: Identifiable, Codable {
    let id: String
    let name: String
    let groupId: String
    let groupName: String
    var indexingCount: Int = 0
    var qaCount: Int = 0
    var rejectedCount: Int = 0

    enum CodingKeys: String, CodingKey {
        case id = "workflow_id"
        case name = "workflow_name"
        case groupId = "group_id"
        case groupName = "group_name"
    }
}
