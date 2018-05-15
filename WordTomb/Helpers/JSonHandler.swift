//
//  JSonHandler.swift
//  WordTomb
//
//  Created by Udeshi on 5/12/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import Foundation


class  JSonHandler{
func loadJSon(filename fileName: String)-> [String: AnyObject]?{
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json"){
        do{
            let data = try Data(contentsOf: url)
   
        let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        if let dictionary = object as? [String: AnyObject]{
            return dictionary
        }
    }catch {
        print (error)
        print ("Error, parsing \(fileName).json")
    }
    }
    return nil
}
}
