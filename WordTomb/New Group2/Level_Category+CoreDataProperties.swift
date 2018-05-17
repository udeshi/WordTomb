//
//  Level_Category+CoreDataProperties.swift
//  WordTomb
//
//  Created by Frank Thamel on 5/17/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//
//

import Foundation
import CoreData


extension Level_Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Level_Category> {
        return NSFetchRequest<Level_Category>(entityName: "Level_Category")
    }

    @NSManaged public var id: Int32
    @NSManaged public var leveli_categoryId: String?
    @NSManaged public var minCoins: Int32
    @NSManaged public var belongsTo: Level?
    @NSManaged public var has: Category?

}
