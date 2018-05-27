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
    
    private class func fetchMaxUserId()->Int32 {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        request.fetchLimit = 1
        request.returnsObjectsAsFaults = false
        
        do {
           let user = try getContext().fetch(request)[0]
            print(user)
            return user.id
        }
        catch{
            return 0
        }
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
            print(cat)
            createCategories(dictionary: cat)
        }
        //_ =  categories.map{saveCategories(dictionary: $0)}
        
        do{
            try context.save()
            print("saved")
        }
        catch{
                 print(error)
        }
    }
    
    
    class func saveUserDetails(userName: String, email: String, password:String) -> Bool{
        let context = getContext()
        let enitity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let manageObject = NSManagedObject(entity: enitity!, insertInto: context)
        
        let id = fetchMaxUserId ()>0 ? fetchMaxUserId() + 1: 1
        
        manageObject.setValue(id, forKey: "id")
        manageObject.setValue(userName, forKey: "userName")
        manageObject.setValue(email, forKey: "email")
        manageObject.setValue(password, forKey: "password")
        
        do{
            try context.save()
            print("saved")
            return true
        }
        catch{
            return false
        }
    }
    
    class func fetchUserDetails(email: String) ->User?{
        let context = getContext()
        let request: NSFetchRequest<User> = User.fetchRequest()
        var user: User? = nil
        
        let predicate = NSPredicate(format: "email like[c] %@", email)
        request.predicate = predicate
        
        do{
            var userResult = try context.fetch(request)
            if(userResult.count > 0){
              user =   userResult[0]
            }
            return user
        }
        catch{
            return user
        }
    }

    class func fetchCategoryDetails() ->[Category]{
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
    
    class func fetchQuestions (level: Int, type: Int)->[Question]{
        let context = getContext()
        let request: NSFetchRequest<Question> = Question.fetchRequest()
        var questions: [Question] = []
       let predicate = NSPredicate(format: "categoryId == %d AND level == %d", type, level)
       request.predicate = predicate
        do{
            questions = try context.fetch(request)
            print(questions.count)
            return questions
        }catch{
            return questions
        }
    }
}
