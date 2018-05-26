//
//  Question+CoreDataProperties.swift
//  WordTomb
//
//  Created by Udeshi on 5/25/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//
//

import Foundation
import CoreData


extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
    }

    @NSManaged public var answer: String?
    @NSManaged public var clue: String?
    @NSManaged public var id: Int32
    @NSManaged public var level: Int32
    @NSManaged public var noOfCoins: Int32
    @NSManaged public var categoryId: Int32
    @NSManaged public var belongsTo: Level?
    @NSManaged public var category: Category?
    @NSManaged public var hints: NSSet?

}

// MARK: Generated accessors for hints
extension Question {

    @objc(addHintsObject:)
    @NSManaged public func addToHints(_ value: Hint)

    @objc(removeHintsObject:)
    @NSManaged public func removeFromHints(_ value: Hint)

    @objc(addHints:)
    @NSManaged public func addToHints(_ values: NSSet)

    @objc(removeHints:)
    @NSManaged public func removeFromHints(_ values: NSSet)

}
