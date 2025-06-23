//
//  Persistence.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 21/04/2025.
//
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        // Create a preview User
        let user = UserEntity(context: viewContext)
        user.id = "1"
        user.name = "John Doe"
        user.apiKey = "sampleApiKey123"

        // Create a preview Workflow
        let workflow = WorkflowEntity(context: viewContext)
        workflow.id = "workflow1"
        workflow.name = "Sample Workflow"
        workflow.groupId = "group1"
        workflow.groupName = "Sample Group"
        workflow.user = user

        // Create a preview Document
        let document = DocumentEntity(context: viewContext)
        document.id = "doc1"
        document.fileName = "Document 1"
        document.numberOfPages = 5
        document.timeReceived = Date()
        document.minutesInQueue = 10
        document.status = "indexing"
        document.workflow = workflow // **Corrected**: Assign workflow to document

        // Save preview context
        do {
            try viewContext.save()
        } catch {
            fatalError("Unresolved error \(error), \((error as NSError).userInfo)")
        }

        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "XtractaDashboardModel")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved Core Data error: \(error), \(error.userInfo)")
            }
        }
    }
}
