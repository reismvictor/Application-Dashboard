//
//  UserSession.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 25/04/2025.
//


import Foundation

class UserSession: ObservableObject {
    static let shared = UserSession()

    @Published var userId: String = ""
    @Published var userName: String = ""
    @Published var apiKey: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false

    private init() {}
}
