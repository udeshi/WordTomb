//
//  SignupScreen.swift
//  WordTomb
//
//  Created by Udeshi on 5/6/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import Foundation
import SpriteKit

class SignupScene: SKScene,SceneNavigator {
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "authScreenBackgroundImage.jpg")
        background.position = CGPoint(x:size.width/2, y:size.height/2)
        
        addChild(background)
        
        // add sub view        
        let tempView = Bundle.main.loadNibNamed("Signup", owner: self, options: nil)?.first as? Signup
        if let tempView = tempView {
            tempView.sceneNavigator = self
            tempView.frame = CGRect(origin: UIScreen.main.bounds.origin, size: UIScreen.main.bounds.size)
            view.addSubview(tempView)
            view.bringSubview(toFront: tempView)
        }
    }
    
    func navigateToScene(screenName: String) {
        if("Dashboard" == screenName) {
            let appDelegate  = UIApplication.shared.delegate as! AppDelegate
            let viewController = appDelegate.window!.rootViewController as! LoginViewController
            viewController.performSegue(withIdentifier: "DashboardNavigationController_Segue", sender: self)
            
        }
        
    }
}
