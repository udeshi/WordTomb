//
//  Line.swift
//  WordTomb
//
//  Created by Udeshi on 6/1/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import SpriteKit

class Line: SKShapeNode {
    var questionLabel : SKLabelNode!
    
    convenience init(width:CGFloat, height:CGFloat, x:CGFloat, y:CGFloat) {
        let frame = CGRect(x: -width/2, y: -height/2, width:width, height: height)
        self.init(rect: frame)
        self.fillColor = UIColor.white
        self.strokeColor = UIColor.white
        self.position = CGPoint(x: x, y : y)
    }
}
