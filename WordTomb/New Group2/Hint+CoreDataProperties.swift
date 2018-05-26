//
//  Hint+CoreDataProperties.swift
//  WordTomb
//
//  Created by Udeshi on 5/25/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//
//

import Foundation
import CoreData


extension Hint {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hint> {
        return NSFetchRequest<Hint>(entityName: "Hint")
    }

    @NSManaged public var questionId: Int32
    @NSManaged public var hint: String?
    @NSManaged public var id: Int32
    @NSManaged public var question: Question?

}
