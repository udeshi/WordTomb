//
//  UserDefaultsHandler.swift
//  WordTomb
//
//  Created by Udeshi on 5/7/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import Foundation

//handle userDefaults (saving and retrieving details)
class  UserDefaultsHandler{
    var defaults = UserDefaults.standard
    //save new record
    func  save(data:String, key : String) {
        var history : [String] = loadHistory(key : key)
        history.append(data)
        defaults.set(history, forKey: key)
    }
    
    func getData(key:String)->Any{
        let value =  defaults.array(forKey: key)
        return value ?? nil
    }
    
    // access all records
    func  getAllData(key:String) -> [String] {
        var history : [String] = loadHistory(key : key);
        history.reverse();
        return history;
    }
    
    private func  loadHistory(key: String) -> [String]{
        var history = [String]()
        let array =  defaults.array(forKey: key)
        if (array != nil){
            for records in array! {
                history.append(records as! String)
            }
        }else{
            print("No past data")
        }
        return history;
    }
    
}
