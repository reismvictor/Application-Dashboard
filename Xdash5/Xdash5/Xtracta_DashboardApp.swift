//
//  Xtracta_DashboardApp.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 18/04/2025.
//

// XtractaDashboardApp.swift
// App root and login switch

import SwiftUI

@main
struct XtractaDashboardApp: App {
    @StateObject private var session = SessionManager()

    var body: some Scene {
        WindowGroup {
            if session.isLoggedIn {
                DashboardView()
                    .environmentObject(session)
            } else {
                LoginView()
                    .environmentObject(session)
            }
        }
    }
}
