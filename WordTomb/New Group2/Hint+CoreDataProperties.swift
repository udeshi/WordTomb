//
//  Hint+CoreDataProperties.swift
//  WordTomb
//
//  Created by Frank Thamel on 5/17/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//
//

import Foundation
import CoreData


extension Hint {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hint> {
        return NSFetchRequest<Hint>(entityName: "Hint")
    }

    @NSManaged public var category_hintId: String?
    @NSManaged public var hint: String?
    @NSManaged public var id: Int32
    @NSManaged public var question: Question?

}
