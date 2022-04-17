//
//  NewsPictureTableCell.swift
//  VK_App
//
//  Created by admin on 20.01.2022.
//

import UIKit
import Kingfisher

class NewsPictureTableCell: UITableViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    
    func configure(stringURL: String) {
        newsImage.kf.setImage(with: URL(string: stringURL))
    }
    
    func config(photo: UIImage) {
        self.newsImage.image = photo
    }
}
