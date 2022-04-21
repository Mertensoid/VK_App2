//
//  NewsTableHeader.swift
//  VK_App
//
//  Created by admin on 20.01.2022.
//

import UIKit
import Kingfisher

class NewsTableHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var authorPic: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var postTime: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(authorName: String, authorPicURL: String, dateOfPost: String) {
        self.authorName.text = authorName
        self.authorPic.kf.setImage(with: URL(string: authorPicURL))
        self.postTime.text = dateOfPost
    }
}
