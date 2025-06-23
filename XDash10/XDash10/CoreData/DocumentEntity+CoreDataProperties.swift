//
//  DocumentEntity+CoreDataProperties.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 24/04/2025.
//
//

import Foundation
import CoreData


extension DocumentEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DocumentEntity> {
        return NSFetchRequest<DocumentEntity>(entityName: "DocumentEntity")
    }

    @NSManaged public var documentID: String?
    @NSManaged public var fileName: String?
    @NSManaged public var pages: Int16
    @NSManaged public var timeReceived: Date?
    @NSManaged public var minutesInQueue: Int16
    @NSManaged public var status: String?
    @NSManaged public var workflowID: String?

}

extension DocumentEntity : Identifiable {

}
