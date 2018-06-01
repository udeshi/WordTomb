//
//  GameQuestionLabel.swift
//  WordTomb
//
//  Created by Udeshi on 5/31/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import SpriteKit

class GameQuestionTileX: SKShapeNode {

    var label : SKLabelNode!
    
    convenience init(width:CGFloat, height:CGFloat) {
        let tileFrame = CGRect(x: -width/2, y: -height/2, width: width, height: height)
        self.init(rect: tileFrame)
        label = SKLabelNode(fontNamed:"Chalkboard SE")
        label.fontColor = UIColor.white
        label.fontSize = 25
        self.addChild(label)
        
    }
}
