//
//  WorkflowDetailModel.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 21/04/2025.
//

import Foundation

/// Represents a document in a queue
struct Document: Identifiable {
    let id: String
    let fileName: String
    let numberOfPages: Int
    let timeReceived: Date
    let minutesInQueue: Int
}

/// Raw response format for each document from API
struct RawDocument: Codable {
    let documentID: String
    let documentStatus: String
    let numberOfPages: String
    let documentURL: String
    let imageURL: [String]
    let delete: String
    let ocrDataURL: String
    let ocrTextURL: String

    enum CodingKeys: String, CodingKey {
        case documentID = "document_id"
        case documentStatus = "document_status"
        case numberOfPages = "number_of_pages"
        case documentURL = "document_url"
        case imageURL = "image_url"
        case delete
        case ocrDataURL = "ocr_data_url"
        case ocrTextURL = "ocr_text_url"
    }
}

/// Wrapper for the "documents_response" object in the API response
struct DocumentsResponseWrapper: Codable {
    let status: Int
    let message: String
    let document: [RawDocument]
    let workflowID: String

    enum CodingKeys: String, CodingKey {
        case status
        case message
        case document
        case workflowID = "workflow_id"
    }
}

/// Root-level object to decode the API response structure
struct DocumentsResponseRoot: Codable {
    let documentsResponse: DocumentsResponseWrapper

    enum CodingKeys: String, CodingKey {
        case documentsResponse = "documents_response"
    }
}
