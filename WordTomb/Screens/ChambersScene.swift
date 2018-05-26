//
//  CHambersScene.swift
//  WordTomb
//
//  Created by Udeshi on 5/19/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import Foundation
import Foundation
import SpriteKit

class ChambersScene: SKScene,SceneNavigator {
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "chambersBackgroundzimage.png")
        background.position = CGPoint(x:size.width/2, y:size.height/2)
        background.size = view.frame.size
        addChild(background)
        
        // add sub view
        let tempView = Bundle.main.loadNibNamed("Chambers", owner: self, options: nil)?.first as? Chambers
        if let tempView = tempView {
            tempView.sceneNavigator = self
            
            view.addSubview(tempView)
            view.bringSubview(toFront: tempView)
        }
    }
    
    func navigateToScene(screenName: String) {
        if("Game" == screenName) {
//            let appDelegate  = UIApplication.shared.delegate as! AppDelegate
//            let viewController = appDelegate.window!.rootViewController as! LoginViewController
//            viewController.performSegue(withIdentifier: "GameNavigationController_Segue", sender: self)
            
            let storybard = UIStoryboard(name: "Main", bundle:nil)
            let vc = storybard.instantiateViewController(withIdentifier: "GameViewController")
            vc.view.frame = (self.view?.frame)!
            vc.view.layoutIfNeeded()
            
            UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations: {
                self.view?.window?.rootViewController = vc
            }, completion: nil)
        }
        
    }
}
