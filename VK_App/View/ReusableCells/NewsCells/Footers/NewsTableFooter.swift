//
//  NewsTableFooter.swift
//  VK_App
//
//  Created by admin on 20.01.2022.
//

import UIKit

class NewsTableFooter: UITableViewHeaderFooterView {
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var repostButton: UIButton!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
    }
    
    func config(likes: Int, comments: Int, reposts: Int) {
        likeButton.titleLabel?.text = "\(likes)"
        commentButton.titleLabel?.text = "\(comments)"
        repostButton.titleLabel?.text = "\(reposts)"
        
        likeButton.layer.cornerRadius = 15.0
        likeButton.clipsToBounds = true
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .highlighted)
        
        commentButton.layer.cornerRadius = 15.0
        commentButton.clipsToBounds = true
        repostButton.layer.cornerRadius = 15.0
        repostButton.clipsToBounds = true
    }
}
