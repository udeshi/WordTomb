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
            user = try context.fetch(request)[0]
            print(user)
            return user
        }
        catch{
            return user
        }
    }

}
