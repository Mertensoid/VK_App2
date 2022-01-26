//
//  NewsTableFooter.swift
//  VK_App
//
//  Created by admin on 20.01.2022.
//

import UIKit

class NewsTableFooter: UITableViewHeaderFooterView {
    
    let likeView: UIView = UIView(frame: CGRect(
        x: 10.0,
        y: 5.0,
        width: 70.0,
        height: 30.0))
    let commentView: UIView = UIView(frame: CGRect(
        x: 90.0,
        y: 5.0,
        width: 70.0,
        height: 30.0))
    let repostView: UIView = UIView(frame: CGRect(
        x: 170.0,
        y: 5.0,
        width: 70.0,
        height: 30.0))
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    @objc func likeButtonPressed() {
        
    }
    
    func configLikeView(count: Int, image: UIImage) {
        self.addSubview(likeView)
//        likeView.layer.borderWidth = 2
//        likeView.layer.borderColor = UIColor.red.cgColor
        likeView.layer.cornerRadius = 15.0
        likeView.layer.backgroundColor = UIColor.lightGray.cgColor
        likeView.clipsToBounds = true
        
        let likeButton: UIButton = UIButton(frame: CGRect(x: 35.0, y: 0.0, width: 30.0, height: 30.0))
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .highlighted)
        likeView.addSubview(likeButton)
        
        let likeCount: UILabel = UILabel(frame: CGRect(x: 10.0, y: 0.0, width: 25.0, height: 30.0))
        likeCount.textAlignment = .center
        likeCount.text = String(count)
        likeCount.minimumScaleFactor = 0.5
        likeCount.adjustsFontSizeToFitWidth = true
        likeView.addSubview(likeCount)
        
//        likeButton.addTarget(
//            self,
//            action: #selector(likeButtonPressed()),
//            for: .touchUpInside)
        
    }

    func configCommentView(count: Int, image: UIImage) {
        self.addSubview(commentView)
//        commentView.layer.borderWidth = 2
//        commentView.layer.borderColor = UIColor.red.cgColor
        commentView.layer.cornerRadius = 15.0
        commentView.layer.backgroundColor = UIColor.lightGray.cgColor
        commentView.clipsToBounds = true
        
        let commentButton: UIButton = UIButton(frame: CGRect(x: 35.0, y: 0.0, width: 30.0, height: 30.0))
        commentButton.setImage(image, for: .normal)
        commentView.addSubview(commentButton)
        
        let commentCount: UILabel = UILabel(frame: CGRect(x: 10.0, y: 0.0, width: 25.0, height: 30.0))
        commentCount.textAlignment = .center
        commentCount.text = String(count)
        commentCount.minimumScaleFactor = 0.5
        commentCount.adjustsFontSizeToFitWidth = true
        commentView.addSubview(commentCount)
    }
    
    func configRepostView(count: Int, image: UIImage) {
        self.addSubview(repostView)
//        repostView.layer.borderWidth = 2
//        repostView.layer.borderColor = UIColor.red.cgColor
        repostView.layer.cornerRadius = 15.0
        repostView.layer.backgroundColor = UIColor.lightGray.cgColor
        repostView.clipsToBounds = true
        
        let repostButton: UIButton = UIButton(frame: CGRect(x: 35.0, y: 0.0, width: 30.0, height: 30.0))
        repostButton.setImage(image, for: .normal)
        repostView.addSubview(repostButton)
        
        let repostCount: UILabel = UILabel(frame: CGRect(x: 10.0, y: 0.0, width: 25.0, height: 30.0))
        repostCount.textAlignment = .center
        repostCount.text = String(count)
        repostCount.minimumScaleFactor = 0.5
        repostCount.adjustsFontSizeToFitWidth = true
        repostView.addSubview(repostCount)
    }
}
