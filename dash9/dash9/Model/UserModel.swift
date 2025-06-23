//
//  UserModel.swift
//  XtractaDashboard
//
//  Created by Victor Reis on 21/04/2025.
//

// Model/UserModel.swift
import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Identifiable {
    @NSManaged public var userId: String
    @NSManaged public var userName: String
    @NSManaged public var userApiKey: String
    @NSManaged public var email: String
    @NSManaged public var password: String?
    @NSManaged public var workflows: Set<Workflow>
}
