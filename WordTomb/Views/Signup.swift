//
//  Signup.swift
//  WordTomb
//
//  Created by Udeshi on 5/8/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import Foundation
import UIKit

class Signup: UIView {
    
    var sceneNavigator : SceneNavigator?

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func getStartedBtnClicked(_ sender: UIButton) {
        email.text = "test@gmail.com"
        userName.text = "test"
        password.text = "user@123"
        if(email.text != "" && userName.text != "" && password.text != ""){
            let userId = CoreDataHandler.saveUserDetails(userName: userName.text!, email: email.text!, password: password.text!)
            if (userId > 0){
                let user = UserDetails(id : Int32(userId), userName : userName.text!, profileImageUrl: "" , email : email.text!)
                
                UserDefaultsHandler().save(data: user,key: "Session")
                sceneNavigator?.navigateToScene(screenName: "Dashboard")
            }
            }else{
                print("error")
            }
       
    }
    
    @IBAction func guestBtnClicked(_ sender: UIButton) {
        sceneNavigator?.navigateToScene(screenName: "Dashboard")
    }
    
}
