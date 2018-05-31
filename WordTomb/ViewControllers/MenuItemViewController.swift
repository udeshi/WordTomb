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
    
    @IBOutlet var contentView: SKView!
    var selectedItemTag = 0
    override func viewDidLoad() {
        //super.viewDidLoad()
         print(selectedItemTag)
        let skView = self.contentView

        switch selectedItemTag{
        case 1001:
            let scene = AboutGameScene(size: CGSize(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            
            scene.scaleMode  = .fill
            skView?.presentScene(scene)
            break
        case 1005:
            let scene = SettingsScene(size: CGSize(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            
            scene.scaleMode  = .fill
            skView?.presentScene(scene)
            break
        default:
            let scene = AboutGameScene(size: CGSize(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            
            scene.scaleMode  = .fill
            skView?.presentScene(scene)
            break
        }
     

    }

}
