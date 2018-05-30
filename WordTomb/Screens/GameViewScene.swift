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
    
    let tile1 : GameTile = GameTile(width: 100, height: 100)
    
    

    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor.brown
        let xPosition = (self.view?.frame.size.width)!/2
        let yPosition = (self.view?.frame.size.height)!/2
        self.anchorPoint = CGPoint(x:0.5, y:0.5)
        //self.position = CGPoint(x:size.width/2, y:size.height/2)
        // add sub view
//        let tempView = Bundle.main.loadNibNamed("Game", owner: self, options: nil)?.first as? Game
//        if let tempView = tempView {
//            tempView.sceneNavigator = self
//            view.addSubview(tempView)
//            view.bringSubview(toFront: tempView)
//        }
        
        loadAssets()
    }
    
    
    func navigateToScene(screenName: String) {
        if("Dashboard" == screenName) {
            let appDelegate  = UIApplication.shared.delegate as! AppDelegate
            let viewController = appDelegate.window!.rootViewController as! LoginViewController
            viewController.performSegue(withIdentifier: "DashboardNavigationController_Segue", sender: self)
            
        }
        
    }
    
    fileprivate func loadAssets() {
        tile1.position = CGPoint(x: 0, y: 0)
        tile1.zPosition = 100
        addChild(tile1)
    }
}
