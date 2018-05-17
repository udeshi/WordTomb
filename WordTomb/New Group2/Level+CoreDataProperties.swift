//
//  Level+CoreDataProperties.swift
//  WordTomb
//
//  Created by Frank Thamel on 5/17/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//
//

import Foundation
import CoreData


extension Level {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Level> {
        return NSFetchRequest<Level>(entityName: "Level")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var has: NSSet?
    @NSManaged public var hasLevel: NSSet?

}

// MARK: Generated accessors for has
extension Level {

    @objc(addHasObject:)
    @NSManaged public func addToHas(_ value: Question)

    @objc(removeHasObject:)
    @NSManaged public func removeFromHas(_ value: Question)

    @objc(addHas:)
    @NSManaged public func addToHas(_ values: NSSet)

    @objc(removeHas:)
    @NSManaged public func removeFromHas(_ values: NSSet)

}

// MARK: Generated accessors for hasLevel
extension Level {

    @objc(addHasLevelObject:)
    @NSManaged public func addToHasLevel(_ value: Level_Category)

    @objc(removeHasLevelObject:)
    @NSManaged public func removeFromHasLevel(_ value: Level_Category)

    @objc(addHasLevel:)
    @NSManaged public func addToHasLevel(_ values: NSSet)

    @objc(removeHasLevel:)
    @NSManaged public func removeFromHasLevel(_ values: NSSet)

}
