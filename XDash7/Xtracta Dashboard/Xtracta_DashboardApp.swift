//
//  Xtracta_DashboardApp.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 21/04/2025.
//

import SwiftUI

@main
struct Xtracta_DashboardApp: App {
     let LoginViewController = LoginViewController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, LoginViewController.container.viewContext)
        }
    }
}
