//
//  Memory+CoreDataProperties.swift
//  Memory Jar
//
//  Created by Tuna Arıkaya on 15.08.2025.
//
//

import Foundation
import CoreData


extension Memory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memory> {
        return NSFetchRequest<Memory>(entityName: "Memory")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var imageData: Data?
    @NSManaged public var text: String?

}

extension Memory : Identifiable {

}
