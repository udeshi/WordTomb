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
    func  save(data:Any, key : String) {
//        var history : [Any] = loadHistory(key : key)
//        history.append(data)
        defaults.set(data, forKey: key)
    }
    
    func getBoolData(key:String)->Bool{
        let value =  defaults.bool(forKey: key)
        return value
    }
    
    func getData(key:String) -> String{
        let value =  defaults.string(forKey: key)
        return value!
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
