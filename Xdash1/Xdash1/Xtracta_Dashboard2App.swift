//
//  Xtracta_Dashboard2App.swift
//  Xtracta Dashboard2
//
//  Created by Victor Reis on 01/04/2025.
//

import SwiftUI

@main
struct Xtracta_Dashboard2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
