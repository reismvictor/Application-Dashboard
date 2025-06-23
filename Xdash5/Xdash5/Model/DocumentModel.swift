// DocumentModel.swift
// Model for a document inside a workflow queue

import Foundation

struct DocumentModel: Identifiable, Codable {
    let id: String
    let numberOfPages: String
    let fileName: String
    let receivedTime: Date

    // Tempo em minutos desde o recebimento
    var minutesSinceReceived: Int {
        let interval = Date().timeIntervalSince(receivedTime)
        return Int(interval / 60)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "document_id"
        case numberOfPages = "number_of_pages"
    }

    // Inicializador com mock de nome e hora aleatória (por enquanto)
    init(from json: [String: Any]) {
        self.id = json["document_id"] as? String ?? "Unknown"
        self.numberOfPages = json["number_of_pages"] as? String ?? "0"
        self.fileName = "File_\(Int.random(in: 1000...9999)).pdf"
        self.receivedTime = Calendar.current.date(byAdding: .minute, value: -Int.random(in: 5...120), to: Date()) ?? Date()
    }
}
