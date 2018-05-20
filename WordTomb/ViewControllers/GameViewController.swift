//
//  GameViewController.swift
//  WordTomb
//
//  Created by Udeshi on 5/5/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
 var currentView : SKView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = self.view as! SKView
        let scene = GameViewScene(size: CGSize(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        scene.scaleMode  = .aspectFill
        currentView = skView
        skView.presentScene(scene)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
}
