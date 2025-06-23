//
//  Persistence.swift
//  XtractaDashboard
//
//  Created by Victor Reis on 21/04/2025.
//

// Model/PersistenceController.swift
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    // ADD THIS BLOCK FOR PREVIEW SUPPORT
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext

        // Optionally, add some demo data for preview
        // let user = User(context: viewContext)
        // user.userId = "preview"
        // user.userName = "Preview User"
        // user.userApiKey = "demo"
        // user.email = "preview@email.com"

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return controller
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "XtractaDashboard")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
