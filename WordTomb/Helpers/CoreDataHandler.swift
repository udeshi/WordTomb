//
//  CoreDataHandler.swift
//  WordTomb
//
//  Created by Udeshi on 5/6/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class  CoreDataHandler: NSObject {
    private class func getContext()-> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    private class func createCategories (dictionary: AnyObject) -> NSManagedObject? {
             let context = getContext()
        if let category = NSEntityDescription.insertNewObject(forEntityName: "Category", into: context) as? Category {
            print(dictionary)
            category.id = (dictionary["id"] as? Int32)!
            category.name = dictionary["name"] as? String
            category.image = dictionary["imageName"] as? String
            category.questions = getQuestionsFor(questionsDictionaries: dictionary["questions"] as? Array, usingManagedObjectContext: context)
            return category
        }
        return nil
    }
    
    private class func getHintsFor (hintsDictionaries: Array<AnyObject>? , usingManagedObjectContext context : NSManagedObjectContext) -> NSSet? {
        
        guard let hintsDictionaries = hintsDictionaries else {
            return nil
        }
        
        var hints : [Hint] = []
        
        for hint in hintsDictionaries {
            let h = Hint(context: context)
            
            if let id = hint["id"] as? Int32, let questionId = hint["questionId"] as? Int32{
                h.id = id
                h.hint = hint["hint"] as? String
                h.questionId = questionId
            }
            hints.append(h)
        }
        
        return NSSet(array: hints)
    }
    
    
    private class func getQuestionsFor(questionsDictionaries: Array<AnyObject>? , usingManagedObjectContext context : NSManagedObjectContext) -> NSSet? {
        
        guard let questionsDictionaries = questionsDictionaries else {
            return nil
        }
        
        var questions : [Question] = []
        
        for question in questionsDictionaries {
            let q = Question(context: context)
            
            if let id = question["id"] as? Int32, let level = question["level"] as? Int32, let noc = question["noOfCoins"] as? Int32 {
                q.id = id
                q.clue = question["clue"] as? String
                q.answer = question["answer"] as? String
                q.level = level
                q.noOfCoins = noc
                q.categoryId = (question["categoryId"] as? Int32)!
                q.hints = getHintsFor(hintsDictionaries: question["hints"] as? Array, usingManagedObjectContext: context)
            }
            questions.append(q)
        }
        
        return NSSet(array: questions)
    }
    
    
    class func initializeGameDetails (){
         let context = getContext()
        let results = JSonHandler().loadJSon(filename: "Category")
        let categories = results!["results"] as! [AnyObject]
        print(categories)
        for cat in categories{
           // print(cat)
            let details = createCategories(dictionary: cat)
            print(details!)
        }
        
        do{
            try context.save()
            print("saved")
        }
        catch{
                 print(error)
        }
    }

}
