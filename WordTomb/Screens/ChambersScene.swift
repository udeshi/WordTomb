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
        // add sub view
        let tempView = Bundle.main.loadNibNamed("Chambers", owner: self, options: nil)?.first as? Chambers
        if let tempView = tempView {
            tempView.sceneNavigator = self
            tempView.frame = CGRect(origin: UIScreen.main.bounds.origin, size: UIScreen.main.bounds.size)
            view.addSubview(tempView)
            view.bringSubview(toFront: tempView)
        }
    }
    
    func navigateToScene(screenName: String) {
        if("Game" == screenName) {
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
