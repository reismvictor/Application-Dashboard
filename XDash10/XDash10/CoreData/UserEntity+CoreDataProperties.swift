//
//  UserEntity+CoreDataProperties.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 24/04/2025.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var userID: String?
    @NSManaged public var userName: String?
    @NSManaged public var apiKey: String?
    @NSManaged public var email: String?
    @NSManaged public var password: String?

}

extension UserEntity : Identifiable {

}
