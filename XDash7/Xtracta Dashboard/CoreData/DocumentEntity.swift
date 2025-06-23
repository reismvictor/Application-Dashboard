//
//  DocumentEntity.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 21/04/2025.
//

import CoreData

@objc(DocumentEntity)
public class DocumentEntity: NSManagedObject {
    @NSManaged public var documentId: String?
    @NSManaged public var documentStatus: String?
    @NSManaged public var numberOfPages: String?
    @NSManaged public var documentUrl: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var ocrDataUrl: String?
    @NSManaged public var ocrTextUrl: String?
    @NSManaged public var receivedTime: Date?
    @NSManaged public var timeInQueue: Double
}
