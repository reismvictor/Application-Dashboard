//
//  Xtracta_DashboardApp.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 01/04/2025.
//

import SwiftUI

@main
struct Xtracta_DashboardApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
