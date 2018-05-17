//
//  MenuViewController.swift
//  WordTomb
//
//  Created by Udeshi on 5/15/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

class MenuViewController: UIViewController{

    var selectedItemTag = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func menuItemclicked(_ sender: UIButton) {
       selectedItemTag = sender.tag
       self.performSegue(withIdentifier: "MenuItemSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MenuItemViewController{
            vc.selectedItemTag = selectedItemTag
        }
    }
}
