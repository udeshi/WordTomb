//
//  Category+CoreDataProperties.swift
//  WordTomb
//
//  Created by Frank Thamel on 5/17/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var id: Int32
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var has: NSSet?
    @NSManaged public var hasLevel: NSSet?
    @NSManaged public var questions: NSSet?

}

// MARK: Generated accessors for has
extension Category {

    @objc(addHasObject:)
    @NSManaged public func addToHas(_ value: User_Category)

    @objc(removeHasObject:)
    @NSManaged public func removeFromHas(_ value: User_Category)

    @objc(addHas:)
    @NSManaged public func addToHas(_ values: NSSet)

    @objc(removeHas:)
    @NSManaged public func removeFromHas(_ values: NSSet)

}

// MARK: Generated accessors for hasLevel
extension Category {

    @objc(addHasLevelObject:)
    @NSManaged public func addToHasLevel(_ value: Level_Category)

    @objc(removeHasLevelObject:)
    @NSManaged public func removeFromHasLevel(_ value: Level_Category)

    @objc(addHasLevel:)
    @NSManaged public func addToHasLevel(_ values: NSSet)

    @objc(removeHasLevel:)
    @NSManaged public func removeFromHasLevel(_ values: NSSet)

}

// MARK: Generated accessors for questions
extension Category {

    @objc(addQuestionsObject:)
    @NSManaged public func addToQuestions(_ value: Question)

    @objc(removeQuestionsObject:)
    @NSManaged public func removeFromQuestions(_ value: Question)

    @objc(addQuestions:)
    @NSManaged public func addToQuestions(_ values: NSSet)

    @objc(removeQuestions:)
    @NSManaged public func removeFromQuestions(_ values: NSSet)

}
