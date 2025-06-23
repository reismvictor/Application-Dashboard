//
//  DocumentModel.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 01/04/2025.
//

import Foundation

// MARK: - Document Model
/// Represents a document in the workflow, conforming to `Codable` for easy JSON decoding.
/// It includes necessary properties extracted from the JSON response.
struct Document: Codable, Identifiable {
    /// Unique identifier for the document (inherited from API response)
    let id: String
    
    /// The ID assigned to the document by the system
    let documentID: String
    
    /// The current status of the document (e.g., "OK", "Rejected")
    let documentStatus: String
    
    /// The date when the document was received, formatted as "dd/MM/yyyy"
    let dateReceived: String
    
    /// The name of the uploaded file (if available)
    let fileName: String?

    // MARK: - Coding Keys
    /// Maps JSON keys to Swift properties to handle different naming conventions.
    /// Helps Swift decode JSON responses correctly.
    enum CodingKeys: String, CodingKey {
        case id
        case documentID = "document_id"
        case documentStatus = "document_status"
        case dateReceived = "received"
        case fileName = "filename"
    }
}

// MARK: - Date Formatter Extensions
/// Provides reusable date formatters for converting API dates to user-friendly formats.
extension DateFormatter {
    
    /// Formatter to parse the API response date format: `"yyyy-MM-dd'T'HH:mm:ssZ"`
    static let apiDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    /// Formatter to display dates in `"dd/MM/yyyy"` format
    static let displayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
}

// MARK: - JSON Parsing Extension
/// Provides functionality to decode JSON data and convert date formats.
extension Document {
    
    /// Decodes JSON data into an array of `Document` objects while formatting dates.
    /// - Parameter jsonData: Raw JSON data received from the API or a file.
    /// - Returns: An array of `Document` objects with formatted dates, or `nil` if decoding fails.
    static func from(jsonData: Data) -> [Document]? {
        do {
            // Decode the JSON data into an array of Document objects
            var documents = try JSONDecoder().decode([Document].self, from: jsonData)
            
            // Loop through documents and convert date formats
            for i in 0..<documents.count {
                if let date = DateFormatter.apiDateFormatter.date(from: documents[i].dateReceived) {
                    // Replace the original date with the formatted version
                    documents[i] = Document(
                        id: documents[i].id,
                        documentID: documents[i].documentID,
                        documentStatus: documents[i].documentStatus,
                        dateReceived: DateFormatter.displayDateFormatter.string(from: date),
                        fileName: documents[i].fileName
                    )
                }
            }
            
            return documents
        } catch {
            // If decoding fails, print an error and return nil
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}






//📝 Explanation of the Code
//✅ 1. Document Struct (Model)
//
//Defines the structure of a document retrieved from JSON.
//Uses Codable to allow easy JSON encoding/decoding.
//The CodingKeys enum maps JSON keys to Swift properties.
//✅ 2. DateFormatter Extension
//
//Provides reusable formatters:
//apiDateFormatter: Parses dates from the API format ("yyyy-MM-dd'T'HH:mm:ssZ").
//displayDateFormatter: Converts dates to a user-friendly dd/MM/yyyy format.
//✅ 3. from(jsonData:) Function
//
//Converts raw JSON into an array of Document objects.
//Loops through each document and converts the received date into the correct format.
//Returns nil if there’s an error in decoding.
