//
//  WorkflowCellView.swift
//  XtractaDashboard
//
//  Created by Victor Reis on 21/04/2025.
//

// View/WorkflowCellView.swift
import SwiftUI

/// Visual cell for a workflow in the dashboard
struct WorkflowCellView: View {
    let workflow: Workflow
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(workflow.workflowName)
                .font(.headline)
            HStack(spacing: 20) {
                QueueCountView(title: "Indexing", count: Int(workflow.indexingCount), color: .blue)
                QueueCountView(title: "QA", count: Int(workflow.qaCount), color: .orange)
                QueueCountView(title: "Rejected", count: Int(workflow.rejectedCount), color: .red)
            }
        }
        .padding(.vertical, 8)
    }
}

private struct QueueCountView: View {
    let title: String
    let count: Int
    let color: Color
    
    var body: some View {
        VStack {
            Text("\(count)")
                .font(.title2)
                .bold()
                .foregroundColor(color)
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(width: 70)
    }
}
