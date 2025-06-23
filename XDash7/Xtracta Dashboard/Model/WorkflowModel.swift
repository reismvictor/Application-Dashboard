// WorkflowModel.swift
// Xtracta Dashboard
//
// Created by Victor Reis on 21/04/2025.

import Foundation
import CoreData

class WorkflowModel: ObservableObject {
    @Published var workflows: [WorkflowEntity] = []
    
    // Recupera a lista de workflows a partir da API
    func fetchWorkflows(apiKey: String, context: NSManagedObjectContext) {
        guard let url = URL(string: "https://api-app.xtracta.com/v1/workflow") else {
            print("❌ Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("❌ Error fetching workflows: \(error.localizedDescription)")
                    return
                }

                guard let data = data else {
                    print("❌ No data received")
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode([WorkflowEntity].self, from: data)

                    // Salvar workflows no Core Data
                    self.saveWorkflowsToCoreData(workflows: decoded, context: context)
                } catch {
                    print("❌ Error decoding workflow data: \(error.localizedDescription)")
                }
            }
        }.resume()
    }

    // Salva workflows no Core Data
    private func saveWorkflowsToCoreData(workflows: [WorkflowEntity], context: NSManagedObjectContext) {
        for workflow in workflows {
            let workflowEntity = WorkflowEntity(context: context)
            workflowEntity.workflowId = workflow.workflowId
            workflowEntity.workflowName = workflow.workflowName
            workflowEntity.groupId = workflow.groupId
            workflowEntity.groupName = workflow.groupName
        }

        do {
            try context.save()
            print("✅ Workflows saved to Core Data successfully.")
        } catch {
            print("❌ Failed to save workflows: \(error.localizedDescription)")
        }
    }

    // Fetch workflows from Core Data
    func fetchWorkflowsFromCoreData(context: NSManagedObjectContext) {
        let request: NSFetchRequest<WorkflowEntity> = WorkflowEntity.fetchRequest()
        
        do {
            let fetchedWorkflows = try context.fetch(request)
            self.workflows = fetchedWorkflows
        } catch {
            print("❌ Failed to fetch workflows from Core Data: \(error.localizedDescription)")
        }
    }
}
