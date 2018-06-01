//
//  UserDetails.swift
//  WordTomb
//
//  Created by Udeshi on 5/30/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import Foundation

class UserDetails: NSObject, NSCoding {
   
    
    
    var id: Int32?
    var userName: String?
    var profileImageUrl: String?
    var email: String?
    
    
    init(id: Int32, userName: String, profileImageUrl: String, email: String){
        self.id = id
        self.userName = userName
        self.profileImageUrl = profileImageUrl
        self.email = email
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let id = Int32(aDecoder.decodeInteger(forKey: "id"))
        let userName = aDecoder.decodeObject(forKey: "userName") as? String
         let profileImageUrl = aDecoder.decodeObject(forKey: "profileImageUrl") as? String
         let email = aDecoder.decodeObject(forKey: "email") as? String
        self.init(id: id, userName: userName!, profileImageUrl: profileImageUrl!, email: email!)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encodeCInt(self.id!, forKey: "id")
        aCoder.encode(self.userName, forKey: "userName")
        aCoder.encode(self.profileImageUrl, forKey: "profileImageUrl")
        aCoder.encode(self.email, forKey: "email")
        
    }
}
