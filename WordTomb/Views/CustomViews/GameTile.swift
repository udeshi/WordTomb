//
//  GameTile.swift
//  WordTomb
//
//  Created by Udeshi on 5/30/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import SpriteKit

class GameTile:SKShapeNode {
    
    var letter : String!
    var x : CGFloat!
    var y : CGFloat!
    var isVerified : Bool = false {
        didSet{
            if isVerified {
                self.bodrderColor = UIColor.green
            }
            else{
                self.bodrderColor = UIColor.red
            }
        }
    }
    var bodrderColor : UIColor = UIColor.white {
        didSet{
            self.strokeColor = self.bodrderColor
        }
    }
    var letterLabel : SKLabelNode?
    
    convenience init(width:CGFloat, height:CGFloat,x:CGFloat,y:CGFloat) {
        let tileFrame = CGRect(x: -width/2, y: -height/2, width: width, height: height)
        self.init(rect: tileFrame)
        self.strokeColor = UIColor.white
        self.fillColor = UIColor.darkGray
        self.lineWidth = 5
        self.letterLabel = SKLabelNode(fontNamed:"Chalkboard SE")
        self.letterLabel?.fontSize = 50
        self.letterLabel?.text = ""
        self.letterLabel?.fontColor = UIColor.white
        self.addChild(letterLabel!)
        self.x =  x
        self.y = y 
    
    }
    
    
}
