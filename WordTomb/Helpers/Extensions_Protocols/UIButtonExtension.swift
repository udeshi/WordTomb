
//
//  UIButtonExtension.swift
//  WordTomb
//
//  Created by Udeshi on 5/15/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import Foundation
import UIKit
// custom styles to button
class UIButtonextension: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setButtonStyle()
    }
    
    override func awakeFromNib() {
        setButtonStyle()
    }
    
    func  setButtonStyle()  {
        let imageOnTop = true
        let gap = 10
        guard let imageView = self.imageView,
            let titleLabel = self.titleLabel else { return }
        
        let sign: CGFloat = imageOnTop ? 1 : -1;
        let imageSize = imageView.frame.size;
        self.titleEdgeInsets = UIEdgeInsetsMake((imageSize.height+10)*sign, -imageSize.width, 0, 0);
        
        let titleSize = titleLabel.bounds.size;
        self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height+10)*sign, 0, 0, -titleSize.width);
        
    }
    
    func setHighlighted(highlighted:Bool){
        
        if highlighted == true{
            highlightBtn()
        }else{
            clearHighlight()
        }
    }
    
    func highlightBtn(){
        self.layer.backgroundColor = UIColor.gray.cgColor
    }
    
    func clearHighlight(){
        self.layer.backgroundColor = UIColor.clear.cgColor
    }
}
