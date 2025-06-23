//
//  Document.swift
//  Xtracta Dashboard3
//
//  Created by Victor Reis on 01/04/2025.
//

import Foundation

// Define the Document model
struct Document: Identifiable {
    var id: String  // Unique identifier for each document
    var status: String
    var receivedDate: Date
}
