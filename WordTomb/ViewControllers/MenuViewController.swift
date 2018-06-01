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

    @IBOutlet weak var logoutBtn: UIButton!
    var selectedItemTag = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let decoded = UserDefaultsHandler().getObj(key: "Session")
        let userDetails = NSKeyedUnarchiver.unarchiveObject(with: decoded as! Data)
        var image = UIImage(named:"userIcon.png")
        if(userDetails != nil) {
            let decodedUserDetails =  userDetails as! UserDetails
            if decodedUserDetails.profileImageUrl! != "" {
                image = UIImage(contentsOfFile: decodedUserDetails.profileImageUrl!)
            }
        }
        //set image for button
        logoutBtn.setImage(image, for: UIControlState.normal)
    }
    
    
    @IBAction func logoutBtnClicked(_ sender: UIButton) {
         UserDefaultsHandler().removeUserdefaults(key: "Session")
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
