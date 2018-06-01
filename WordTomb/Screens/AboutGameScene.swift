//
//  AboutGameScene.swift
//  WordTomb
//
//  Created by Udeshi on 5/27/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import Foundation

import SpriteKit

class AboutGameScene: SKScene,SceneNavigator {
    
    override func didMove(to view: SKView) {
        
        // add sub view
        let tempView = Bundle.main.loadNibNamed("AboutGame", owner: self, options: nil)?.first as? AboutGame
        if let tempView = tempView {
            tempView.sceneNavigator = self
            tempView.frame = CGRect(origin: UIScreen.main.bounds.origin, size: UIScreen.main.bounds.size)
            view.addSubview(tempView)
            view.frame = CGRect(origin: UIScreen.main.bounds.origin, size: UIScreen.main.bounds.size)
            view.bringSubview(toFront: tempView)
        }
    }
    
    func navigateToScene(screenName: String) {
        
        
    }
}
