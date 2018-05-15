//
//  CommonHelper.swift
//  WordTomb
//
//  Created by Udeshi on 5/13/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import Foundation
class  Common{
    func getRandomNumber(arrayCount: Int)-> Int{
        return   Int(arc4random_uniform(UInt32(arrayCount)))
    }
}
