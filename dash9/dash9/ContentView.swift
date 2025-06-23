//
//  ContentView.swift
//  XtractaDashboard
//
//  Created by Victor Reis on 21/04/2025.
//
import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    // Usando 'Workflow' em vez de 'Item'
    @FetchRequest(
        sortDescriptors: [],
        animation: .default
    )
    private var workflows: FetchedResults<Workflow>

    var body: some View {
        NavigationView {
            List {
                ForEach(workflows) { workflow in
                    NavigationLink(destination: Text("Detail for \(workflow.workflowName ?? "Unknown")")) {
                        Text(workflow.workflowName ?? "Untitled Workflow")
                    }
                }
            }
            .navigationTitle("Workflows")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newWorkflow = Workflow(context: viewContext)
            newWorkflow.workflowName = "New Workflow" // Defina um nome padrão

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { workflows[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
