//
//  GameLettersTableViewCell.swift
//  WordTomb
//
//  Created by Udeshi on 5/26/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import UIKit

class GameLettersTableViewCell: UITableViewCell {
  @IBOutlet weak var rightLetterButton: UIButton!
      @IBOutlet weak var leftLetterButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
