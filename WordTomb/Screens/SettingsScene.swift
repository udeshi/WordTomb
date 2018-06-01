//
//  Settings.swift
//  WordTomb
//
//  Created by Udeshi on 5/26/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import Foundation

import SpriteKit

class SettingsScene: SKScene,SceneNavigator {
    
    override func didMove(to view: SKView) {
        
        // add sub view
        let tempView = Bundle.main.loadNibNamed("Settings", owner: self, options: nil)?.first as? Settings
        if let tempView = tempView {
            tempView.frame = CGRect(origin: UIScreen.main.bounds.origin, size: UIScreen.main.bounds.size)
            tempView.sceneNavigator = self
            view.addSubview(tempView)
            view.bringSubview(toFront: tempView)
        }
    }
    
    func navigateToScene(screenName: String) {
       
        
    }
}
