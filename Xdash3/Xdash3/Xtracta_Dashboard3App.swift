//
//  Xtracta_Dashboard3App.swift
//  Xtracta Dashboard3
//
//  Created by Victor Reis on 01/04/2025.
//

import SwiftUI

@main
struct Xtracta_Dashboard3App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
