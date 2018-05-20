//
//  DashboardViewController.swift
//  WordTomb
//
//  Created by Udeshi on 5/6/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

class DashboardViewController: UIViewController {
    
    
    @IBOutlet weak var hamgurgerMenu: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hamgurgerMenu.isHidden = true
    }
    
    @IBAction func menuButtonClicked(_ sender: Any) {
        
        UIView.transition(with: hamgurgerMenu, duration: 0.8, options: [.curveEaseInOut, .transitionCrossDissolve] , animations: { self.hamgurgerMenu.isHidden = !self.hamgurgerMenu.isHidden })
//        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
//            self.hamgurgerMenu.layoutIfNeeded()
//        }) { (animationComplete) in
//            print("The animation is complete!")
//        }

    }

    
    
}
