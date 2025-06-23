//
//  WorkflowModel.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 15/04/2025.
//

import Foundation

// MARK: - Workflow Model
struct WorkflowDetailModel {
    var workflowID: String
    var workflowName: String
    var groupID: String
    var groupName: String
    var indexingQueue: Int
    var qualityAssuranceQueue: Int
    var rejectedQueue: Int
    
    // MARK: - Initializer
    init(workflowID: String, workflowName: String, groupID: String, groupName: String, indexingQueue: Int, qualityAssuranceQueue: Int, rejectedQueue: Int) {
        self.workflowID = workflowID
        self.workflowName = workflowName
        self.groupID = groupID
        self.groupName = groupName
        self.indexingQueue = indexingQueue
        self.qualityAssuranceQueue = qualityAssuranceQueue
        self.rejectedQueue = rejectedQueue
    }
}
