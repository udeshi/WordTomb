//
//  GameQuestionTile.swift
//  WordTomb
//
//  Created by Udeshi on 5/31/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import SpriteKit

class GameQuestionTile: SKShapeNode {
    var questionLabel : SKLabelNode!
    
    convenience init(width:CGFloat, height:CGFloat) {
        let tileFrame = CGRect(x: -width/2, y: -height/2, width: width, height: height)
        self.init(rect: tileFrame)
        self.strokeColor = UIColor.clear
        self.questionLabel = SKLabelNode(fontNamed:"Chalkboard SE")
        self.questionLabel.preferredMaxLayoutWidth = width
        self.questionLabel?.fontSize = 20
        self.questionLabel?.fontColor = UIColor.white
        self.questionLabel.numberOfLines = 2
        self.questionLabel.horizontalAlignmentMode = .left
        self.addChild(questionLabel!)
        
    }
}
