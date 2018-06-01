//
//  Question+CoreDataClass.swift
//  WordTomb
//
//  Created by Frank Thamel on 5/17/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Question)
public class Question: NSManagedObject {
    fileprivate func getContext()-> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func fetchQuestions (level: Int, type: Int)->[Question]{
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
