//
//  Document.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 25/04/2025.
//

import Foundation

// Modelo para armazenar informações sobre documentos
struct Document: Identifiable {
    var id: String { documentId } // Conformidade com Identifiable
    var documentId: String
    var fileName: String
    var numberOfPages: Int
    var timeReceived: Date // Para armazenar o tempo de recebimento
}

