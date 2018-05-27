//
// LoginViewController.swift
//  WordTomb
//
//  Created by Udeshi on 5/5/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class LoginViewController: UIViewController {
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    var sceneNavigator : SceneNavigator?
    
    @IBOutlet weak var loginForm: UIView!
    var currentView : SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let skView = self.view as! SKView
        let scene = LoginScene(size: CGSize(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        scene.scaleMode  = .aspectFill
        currentView = skView
        skView.presentScene(scene)
        let isInitialized = UserDefaultsHandler().getBoolData(key: "isInitialized")
        print(isInitialized)
        if (!isInitialized){
            CoreDataHandler.initializeGameDetails()
            UserDefaultsHandler().save(data: true, key: "isInitialized")
            
        }
    }

    @IBAction func getStartedBtnClicked(_ sender: UIButton) {
        if(email.text != "" && password.text != ""){
            let user = CoreDataHandler.fetchUserDetails(email:email.text! )
            if(( user ) != nil){
                print("saved user" + (user?.password)!)
                user?.password == password.text! ? print("print correct user"): print("try again")
                UserDefaultsHandler().save(data: (user?.userName)!,key: "Session")
                
                 sceneNavigator?.navigateToScene(screenName: "Dashboard")
            }
      
        }
    }
    @IBAction func createAccountBtnClicked(_ sender: UIButton) {
        let reveal = SKTransition.flipHorizontal(withDuration: 1.0)
        //let skView = self.view as! SKView
        let signupScreen = SignupScene(size: CGSize(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        signupScreen.scaleMode  = .aspectFill
        signupScreen.size = UIScreen.main.bounds.size
       self.loginForm.isHidden = true
    currentView.presentScene(signupScreen, transition: reveal)
    }
    @IBAction func guestBtnClciked(_ sender: UIButton) {
        sceneNavigator?.navigateToScene(screenName: "Dashboard")
    }
    
    
}
