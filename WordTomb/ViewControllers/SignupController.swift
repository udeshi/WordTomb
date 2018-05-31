//
//  SignupController.swift
//  WordTomb
//
//  Created by Udeshi on 5/6/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

class SignupViewController: UIViewController {
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
     var sceneNavigator : SceneNavigator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let skView = self.view as! SKView
//        let scene = SignupScene(size: CGSize(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
//        
//        scene.scaleMode  = .aspectFill
//        skView.presentScene(scene)
        
    }

    @IBAction func signupBtnClicked(_ sender: Any) {
        let userId = CoreDataHandler.saveUserDetails(userName: "user1", email: "user@123", password: "123456")
        if (userId > 0){
            let user: User = User()
            user.id = Int32(userId)
            user.userName = "user1";
            user.email = email.text;
            
            UserDefaultsHandler().save(data: user,key: "Session")
            
            sceneNavigator?.navigateToScene(screenName: "Dashboard")
        }else{
            print("error")
        }
        
    }
    
}
