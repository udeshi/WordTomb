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

class GameViewController: UIViewController,GameDelegate {
    
    
    func showGameCompleteAlert() {
        let alert = UIAlertController(title: "Completed", message: "You have successfully completed the puzzel", preferredStyle: UIAlertControllerStyle.alert);
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.navigateToDashboardView()
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func gameSceneBackButton() {
        navigateToDashboardView()
    }
    
    func navigateToDashboardView() {
        performSegue(withIdentifier: "gameToDashboard",sender: nil)
        
    }
    
 var currentView : SKView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = self.view as! SKView
        let scene = GameViewScene(size: CGSize(width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scene.currentController = self
        scene.scaleMode  = .aspectFill
        scene.gameDelegate =  self
        currentView = skView
        skView.presentScene(scene)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
}
