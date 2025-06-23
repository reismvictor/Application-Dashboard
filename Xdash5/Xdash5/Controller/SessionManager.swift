//
//  SessionManager.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 18/04/2025.
//

// SessionManager.swift
// Manages login session state

import Foundation
import SwiftUI

class SessionManager: ObservableObject {
    @AppStorage("userApiKey") var userApiKey: String = ""
    @Published var isLoggedIn: Bool = false

    init() {
        // Set initial login status based on stored API key
        isLoggedIn = !userApiKey.isEmpty
    }

    func logIn(with apiKey: String) {
        userApiKey = apiKey
        isLoggedIn = true
    }

    func logOut() {
        userApiKey = ""
        isLoggedIn = false
    }
}
