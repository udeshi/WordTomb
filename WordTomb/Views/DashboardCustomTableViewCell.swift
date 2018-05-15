//
//  DashboardCustomTableViewCell.swift
//  WordTomb
//
//  Created by Udeshi on 5/12/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import UIKit

class DashboardCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var evenCategoryName: UILabel!
    @IBOutlet weak var oddCategoryName: UILabel!

    @IBOutlet weak var evenCategoryImage: UIImageView!
    @IBOutlet weak var oddCategoryImage: UIImageView!
    
    @IBOutlet weak var oddCellView: UIView!
    @IBOutlet weak var evenCellView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
