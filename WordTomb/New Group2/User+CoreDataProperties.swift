//
//  User+CoreDataProperties.swift
//  WordTomb
//
//  Created by Udeshi on 5/27/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: Int32
    @NSManaged public var password: String?
    @NSManaged public var profileImageUrl: NSData?
    @NSManaged public var userName: String?
    @NSManaged public var has: NSSet?

}

// MARK: Generated accessors for has
extension User {

    @objc(addHasObject:)
    @NSManaged public func addToHas(_ value: User_Category)

    @objc(removeHasObject:)
    @NSManaged public func removeFromHas(_ value: User_Category)

    @objc(addHas:)
    @NSManaged public func addToHas(_ values: NSSet)

    @objc(removeHas:)
    @NSManaged public func removeFromHas(_ values: NSSet)

}
