//
//  Category+CoreDataClass.swift
//  WordTomb
//
//  Created by Frank Thamel on 5/17/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Category)
public class Category: NSManagedObject {
    fileprivate func getContext()-> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func fetchCategoryDetails() ->[Category]{
        let context = getContext()
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        var categories: [Category] = []
        
        do{
            categories = try context.fetch(request)
            print(categories.count)
            return categories
        }catch{
            return categories
        }
    }
}
