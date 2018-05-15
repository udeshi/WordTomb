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
        background.size = view.frame.size
        addChild(background)
        
        // add sub view        
        let tempView = Bundle.main.loadNibNamed("Signup", owner: self, options: nil)?.first as? Signup
        if let tempView = tempView {
            tempView.sceneNavigator = self
            view.addSubview(tempView)
            view.bringSubview(toFront: tempView)
        }
    }
    
    func navigateToScene(screenName: String) {
        let reveal = SKTransition.flipHorizontal(withDuration: 1.0)
        
        let dashboardScreen = DashboardScene(size: CGSize(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        if(String(describing: dashboardScreen) == screenName) {
//            dashboardScreen.scaleMode  = .aspectFill
//            self.view?.presentScene(dashboardScreen, transition: reveal)
            let dashboardViewController = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "DashboardViewController")
            self.present(dashboardViewController, animated: true, completion: nil)
        }
        
    }
}
