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
    
   
    
    //    let authorPicture = UIImageView()
//    let authorLabel = UILabel()
//    let postTimeLabel = UILabel()

    override func prepareForReuse() {
        super.prepareForReuse()
        
//        authorPicture.frame = CGRect(x: 10, y: 5, width: 64, height: 64)
//        self.addSubview(authorPicture)
//
//        authorLabel.frame = CGRect(x: 84, y: 5, width: 400, height: 20)
//        self.addSubview(authorLabel)
//
//        postTimeLabel.frame = CGRect(x: 84, y: 25, width: 400, height: 20)
//        postTimeLabel.textColor = .lightGray
//        self.addSubview(postTimeLabel)
    }
    
    func configure(authorName: String, authorPicURL: String, dateOfPost: String) {
        self.authorName.text = authorName
        self.authorPic.kf.setImage(with: URL(string: authorPicURL))
        self.postTime.text = dateOfPost
    }
    
    func configure(source: Int, date: String) {
        self.authorName.text = String(source)
//        self.authorName.text = authorName
//        self.authorPic.kf.setImage(with: URL(string: authorPicURL))
        self.postTime.text = date
    }
}
