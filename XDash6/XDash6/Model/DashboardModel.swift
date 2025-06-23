//
//  DashboardModel.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 21/04/2025.
//

import Foundation

/// Represents a single Workflow returned by the API.
struct Workflow: Codable, Identifiable {
    let id: String             // workflow_id
    let name: String           // workflow_name
    let groupId: String        // group_id
    let groupName: String      // group_name
    
    enum CodingKeys: String, CodingKey {
        case id = "workflow_id"
        case name = "workflow_name"
        case groupId = "group_id"
        case groupName = "group_name"
    }
}

/// Wrapper to decode the list of workflows from API response.
struct WorkflowResponse: Codable {
    let workflows: [Workflow]
    
    enum CodingKeys: String, CodingKey {
        case workflows = "workflow_response"
    }
}
