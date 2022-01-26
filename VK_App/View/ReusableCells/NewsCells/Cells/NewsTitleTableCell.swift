//
//  NewsTitleTableCell.swift
//  VK_App
//
//  Created by admin on 20.01.2022.
//

import UIKit

class NewsTitleTableCell: UITableViewCell {
    
    @IBOutlet weak var newsTitleLabel: UILabel!
    
    func configure(text: String) {
        newsTitleLabel.text = text
    }
}
