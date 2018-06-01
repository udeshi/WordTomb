//
//  CGFloatExtension.swift
//  WordTomb
//
//  Created by Udeshi on 5/31/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat
{
    func getminimum(value2:CGFloat)->CGFloat
    {
        if self < value2
        {
            return self
        }
        else
        {
            return value2
        }
    }
}
