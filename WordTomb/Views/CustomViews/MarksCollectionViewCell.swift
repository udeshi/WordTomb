//
//  MarksCollectionViewCell.swift
//  WordTomb
//
//  Created by Udeshi on 5/27/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import UIKit

class MarksCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var userMarks: UILabel!
    
    @IBOutlet weak var userRanking: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
