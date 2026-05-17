//
//  Memo+CoreDataProperties.swift
//  SwiftUICoreData
//
//  Created by Hiromichi Sase on 2025/01/20.
//
//

import Foundation
import CoreData


extension Memo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memo> {
        return NSFetchRequest<Memo>(entityName: "Memo")
    }

    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var content: String
    @NSManaged public var createdAt: Date
    @NSManaged public var updatedAt: Date
    @NSManaged public var order: Int

}

extension Memo : Identifiable {

}
