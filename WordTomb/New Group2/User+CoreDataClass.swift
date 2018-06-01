//
//  User+CoreDataClass.swift
//  WordTomb
//
//  Created by Frank Thamel on 5/17/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(User)
public class User: NSManagedObject {

    fileprivate func getContext()-> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    fileprivate func fetchMaxUserId()->Int32 {
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
    
    func saveUserDetails(userName: String, email: String, password:String) -> Int{
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
            return Int(id)
        }
        catch{
            return 0
        }
    }
    
    func fetchUserDetails(email: String) ->User?{
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
    
    func updateUserProfile(profilePath: String, userId: Int32){
        let context = getContext()
        let request: NSFetchRequest<User> = User.fetchRequest()
  
        
        let predicate = NSPredicate(format: "id = %d", userId)
        request.predicate = predicate
        
        do{
            var userResult = try context.fetch(request)
            if(userResult.count > 0){
               let user =   userResult[0] as NSManagedObject
   
                    user.setValue(profilePath, forKey: "profileImageUrl")
                    do{
                        try context.save()
                    }catch{
                        print("didn't save")
                    }
                
            }
            
        }
        catch{
            print("try again")
        }
    }
    
}
