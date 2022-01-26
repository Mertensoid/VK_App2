//
//  NewsTableHeader.swift
//  VK_App
//
//  Created by admin on 20.01.2022.
//

import UIKit

class NewsTableHeader: UITableViewHeaderFooterView {

    override func prepareForReuse() {
        super.prepareForReuse()
        
        //self.clipsToBounds = false
        
    }
    
    func configure(authorPic: UIImage, authorName: String, time: String) {
        
        let authorPicture = UIImageView()
        let authorLabel = UILabel()
        let postTimeLabel = UILabel()
        
        authorPicture.frame = CGRect(x: 10, y: 5, width: 64, height: 64)
        authorPicture.image = authorPic
        addSubview(authorPicture)
        
        authorLabel.frame = CGRect(x: 84, y: 5, width: 400, height: 20)
        authorLabel.text = authorName
        addSubview(authorLabel)
        
        postTimeLabel.frame = CGRect(x: 84, y: 25, width: 400, height: 20)
        postTimeLabel.textColor = .lightGray
        postTimeLabel.text = time
        addSubview(postTimeLabel)
    }

}
