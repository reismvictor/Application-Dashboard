//
//  CoreDataManager.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 21/04/2025.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private let ctx = PersistenceController.shared.container.viewContext

    // Save User
    func saveUser(id: String, name: String, apiKey: String) {
        let u = UserEntity(context: ctx)
        u.id = id
        u.name = name
        u.apiKey = apiKey
        saveContext()
    }

    // Fetch User (first)
    func fetchUser() -> UserEntity? {
        let req: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        return try? ctx.fetch(req).first
    }

    // Save Workflow
    func saveWorkflow(id: String, name: String, groupId: String, groupName: String, user: UserEntity) {
        let w = WorkflowEntity(context: ctx)
        w.id = id
        w.name = name
        w.groupId = groupId
        w.groupName = groupName
        w.user = user
        saveContext()
    }

    // Fetch Workflows
    func fetchWorkflows() -> [WorkflowEntity] {
        let req: NSFetchRequest<WorkflowEntity> = WorkflowEntity.fetchRequest()
        return (try? ctx.fetch(req)) ?? []
    }

    // Save Document
    func saveDocument(id: String, fileName: String, pages: Int, timeReceived: Date, minutesInQueue: Int, status: String, workflow: WorkflowEntity) {
        let d = DocumentEntity(context: ctx)
        d.id = id
        d.fileName = fileName
        d.numberOfPages = Int16(pages)
        d.timeReceived = timeReceived
        d.minutesInQueue = Int16(minutesInQueue)
        d.status = status
        d.workflow = workflow
        saveContext()
    }

    // Fetch Documents for a workflow
    func fetchDocuments(for workflow: WorkflowEntity) -> [DocumentEntity] {
        let req: NSFetchRequest<DocumentEntity> = DocumentEntity.fetchRequest()
        req.predicate = NSPredicate(format: "workflow == %@", workflow)
        return (try? ctx.fetch(req)) ?? []
    }

    private func saveContext() {
        do { try ctx.save() }
        catch { print("CoreData save error: \(error)") }
    }
}
