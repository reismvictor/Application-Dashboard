//
//  XtractaDashboardApp.swift
//  XtractaDashboard
//
//  Created by Victor Reis on 21/04/2025.
//

import SwiftUI

@main
struct XtractaDashboardApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
