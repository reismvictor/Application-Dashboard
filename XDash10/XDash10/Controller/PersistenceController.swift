//
//  PersistenceController.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 24/04/2025.
//

import CoreData
import Foundation

/// Singleton to manage the Core Data stack
struct PersistenceController {
    static let shared = PersistenceController()

    // Core Data container
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "XtractaDashboard") // Match this name with your .xcdatamodeld file

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("❌ Failed to load Core Data stack: \(error.localizedDescription)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    /// Helper to save context
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("❌ Failed to save Core Data context: \(error.localizedDescription)")
            }
        }
    }
}

