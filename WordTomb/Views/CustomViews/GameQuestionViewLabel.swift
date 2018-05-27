//
//  GameQuestionViewLable.swift
//  WordTomb
//
//  Created by Udeshi on 5/27/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import UIKit

class GameQuestionViewLabel : UILabel {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    func commonInit(){
        self.numberOfLines = 2
        self.font = UIFont(name: self.font.fontName, size: 20)
        self.lineBreakMode = .byWordWrapping
    }

}
