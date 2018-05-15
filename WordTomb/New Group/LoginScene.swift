//
//  LoginScreen.swift
//  WordTomb
//
//  Created by Udeshi on 5/5/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import Foundation
import SpriteKit

class LoginScene: SKScene {
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "authScreenBackgroundImage.jpg")
        background.position = CGPoint(x:size.width/2, y:size.height/2)
        background.size = view.frame.size
        addChild(background)
    }
    
    func navigateToScene(screenName: String) {
//        let reveal = SKTransition.flipHorizontal(withDuration: 1.0)
//
//        let dashboardScreen = DashboardScene(size: CGSize(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
//        if(String(describing: dashboardScreen) == screenName) {
//            dashboardScreen.scaleMode  = .aspectFill
//            self.view?.presentScene(dashboardScreen, transition: reveal)
//        }
        if("Dashboard" == screenName) {
            let appDelegate  = UIApplication.shared.delegate as! AppDelegate
            let viewController = appDelegate.window!.rootViewController as! LoginViewController
            viewController.performSegue(withIdentifier: "DashboardNavigationController_Segue", sender: self)
            
        }
    }
}
