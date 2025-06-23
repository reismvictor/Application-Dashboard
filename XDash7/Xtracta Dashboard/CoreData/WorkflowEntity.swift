// WorkflowEntity.swift
// Xtracta Dashboard
//
// Created by Victor Reis on 21/04/2025.

import Foundation

// Modelo para dados de workflow que vêm da API
struct WorkflowEntity: Codable {
    var workflowId: String
    var workflowName: String
    var groupId: String
    var groupName: String
}
