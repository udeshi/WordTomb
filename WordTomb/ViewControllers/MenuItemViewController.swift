//
//  File.swift
//  WordTomb
//
//  Created by Udeshi on 5/16/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import Foundation
import Foundation
import UIKit
import SpriteKit
import GameplayKit

class MenuItemViewController: UIViewController{
    
    @IBOutlet var contentView: UIView!
    var selectedItemTag = 0
    var currentView : SKView!
    override func viewDidLoad() {
        super.viewDidLoad()
         print(selectedItemTag)
        let skView = self.view as! SKView
        let scene = SettingsScene(size: CGSize(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        scene.scaleMode  = .aspectFill
        currentView = skView
        skView.presentScene(scene)

    }

}
