//
//  WorkflowEntity+CoreDataProperties.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 24/04/2025.
//
//

import Foundation
import CoreData

extension WorkflowEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkflowEntity> {
        return NSFetchRequest<WorkflowEntity>(entityName: "WorkflowEntity")
    }

    @NSManaged public var workflowID: String?
    @NSManaged public var workflowName: String?  // Esse campo deve estar presente
    @NSManaged public var groupID: String?
    @NSManaged public var groupName: String?

    /// Propriedade computada para garantir um identificador único seguro
    public var safeID: String {
        workflowID ?? UUID().uuidString
    }
}

extension WorkflowEntity : Identifiable {
}
