//
//  DashboardView.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 21/04/2025.
//

import SwiftUI
import CoreData

struct DashboardView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \WorkflowEntity.name, ascending: true)],
        animation: .default
    ) private var workflows: FetchedResults<WorkflowEntity>

    var body: some View {
        List {
            ForEach(workflows) { wf in
                NavigationLink(destination: Text("Workflow Detail")) { // Replace with your detail view
                    Text(wf.name ?? "Unknown Workflow")
                }
            }
        }
        .navigationTitle("Workflows")
    }
}
