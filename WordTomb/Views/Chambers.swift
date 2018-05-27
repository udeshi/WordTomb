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
        let value = sender.tag
       UserDefaultsHandler().save(data: value, key: "selectedLevel")
    sceneNavigator?.navigateToScene(screenName: "Game")

    }

}
