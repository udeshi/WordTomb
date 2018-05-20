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
    
    @IBAction func getSignupBtnClicked(_ sender: UIButton) {
        if(email.text != "" && userName.text != "" && password.text != ""){
            if (CoreDataHandler.saveUserDetails(userName: userName.text!, email: email.text!, password: password.text! )){
                sceneNavigator?.navigateToScene(screenName: "Dashboard")
            }else{
                print("error")
            }
        }
        
        
       
    }
    
}
