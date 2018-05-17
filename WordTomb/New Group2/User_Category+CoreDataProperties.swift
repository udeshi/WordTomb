//
//  User_Category+CoreDataProperties.swift
//  WordTomb
//
//  Created by Frank Thamel on 5/17/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//
//

import Foundation
import CoreData


extension User_Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User_Category> {
        return NSFetchRequest<User_Category>(entityName: "User_Category")
    }

    @NSManaged public var dateTime: NSDate?
    @NSManaged public var score: Int32
    @NSManaged public var user_categoryId: String?
    @NSManaged public var belongsTo: User?
    @NSManaged public var has: Category?

}
