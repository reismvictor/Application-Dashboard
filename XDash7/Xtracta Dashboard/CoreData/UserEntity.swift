//
//  UserEntity.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 21/04/2025.
//

import CoreData

@objc(UserEntity)
public class UserEntity: NSManagedObject {
    @NSManaged public var userId: String?
    @NSManaged public var userName: String?
    @NSManaged public var apiKey: String?
}
