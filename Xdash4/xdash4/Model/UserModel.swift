//
//  UserModel.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 15/04/2025.
//
import Foundation

// MARK: - User model structure
/// Stores data received from login API.
struct User {
    let userID: String       // Unique identifier for the user
    let userName: String     // Display name of the user
    let apiKey: String       // Required for authenticated API calls
}

