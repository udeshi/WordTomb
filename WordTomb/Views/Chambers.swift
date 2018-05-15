//
//  Chambers.swift
//  WordTomb
//
//  Created by Udeshi on 5/13/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import UIKit

class Chambers: UIView {
    var sceneNavigator : SceneNavigator?

    @IBAction func chamberSelected(_ sender: UIButton) {
        //save level to user defaults
        // add sub view
        let tempView = Bundle.main.loadNibNamed("Game", owner: self, options: nil)?.first as? Game
        if let tempView = tempView {
            self.addSubview(tempView)
            self.bringSubview(toFront: tempView)
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
