//
//  NewsPictureTableCell.swift
//  VK_App
//
//  Created by admin on 20.01.2022.
//

import UIKit

class NewsPictureTableCell: UITableViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    
    func configure(image: UIImage) {
        newsImage.image = image
    }
}
