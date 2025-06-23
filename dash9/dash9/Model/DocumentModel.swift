//
//  DocumentModel.swift
//  XtractaDashboard
//
//  Created by Victor Reis on 21/04/2025.
//

// Model/DocumentModel.swift
import Foundation
import CoreData

@objc(Document)
public class Document: NSManagedObject, Identifiable {
    @NSManaged public var documentId: String
    @NSManaged public var fileName: String
    @NSManaged public var numberOfPages: Int32
    @NSManaged public var timeReceived: Date
    @NSManaged public var status: String
    @NSManaged public var workflow: Workflow
}
