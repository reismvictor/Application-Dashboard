//
//  Xtracta_DashboardApp.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 25/04/2025.
//


import SwiftUI

@main
struct Xtracta_DashboardApp: App {
    @StateObject private var session = UserSession.shared

    var body: some Scene {
        WindowGroup {
            if session.isLoggedIn {
                DashboardView()
            } else {
                LoginView()
            }
        }
    }
}
