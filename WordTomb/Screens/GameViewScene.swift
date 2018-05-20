//
//  GameSceen.swift
//  WordTomb
//
//  Created by Udeshi on 5/13/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import Foundation
import SpriteKit

class GameViewScene: SKScene,SceneNavigator {

    override func didMove(to view: SKView) {
        
        
        // add sub view
        let tempView = Bundle.main.loadNibNamed("Game", owner: self, options: nil)?.first as? Game
        if let tempView = tempView {
            tempView.sceneNavigator = self
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
