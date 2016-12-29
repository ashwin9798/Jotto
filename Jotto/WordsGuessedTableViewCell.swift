//
//  WordsGuessedTableViewCell.swift
//  Jotto
//
//  Created by Ashwin Vivek on 12/28/16.
//  Copyright © 2016 AshwinVivek. All rights reserved.
//

import UIKit

class WordsGuessedTableViewCell: UITableViewCell {

    @IBOutlet weak var wordGuessedLabel: UILabel!
    @IBOutlet weak var lettersCorrectLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
    
    
}
