//
//  WorkflowMode.swift
//  XtractaDashboard
//
//  Created by Victor Reis on 21/04/2025.
//

// Model/WorkflowModel.swift
import Foundation
import CoreData

@objc(Workflow)
public class Workflow: NSManagedObject, Identifiable {
    @NSManaged public var workflowId: String
    @NSManaged public var workflowName: String
    @NSManaged public var indexingCount: Int32
    @NSManaged public var qaCount: Int32
    @NSManaged public var rejectedCount: Int32
    @NSManaged public var user: User
    @NSManaged public var documents: Set<Document>
}
