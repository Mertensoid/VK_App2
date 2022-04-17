//
//  UserCollectionViewCell.swift
//  VK_App
//
//  Created by admin on 26.12.2021.
//

import UIKit
import Kingfisher

class UserPhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesCount: UILabel!
    
    var tempCount: String = ""
    var somePhotoModel: UserPhoto? = nil
    var likedVar: Bool = false
    
    //ДЗ №5
    @IBAction func likeButtonPressed(_ sender: UIButton) {
//        if sender.imageView?.image == UIImage(systemName: "heart.fill") {
//            sender.setImage(UIImage(systemName: "heart"), for: .normal)
//        } else {
//            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//        }
//        likedVar = !likedVar
//        if likedVar {
//            somePhotoModel?.likesCount += 1
//            tempCount = String(somePhotoModel!.likesCount)
//            UIView.transition(
//                with: likesCount,
//                duration: 0.5,
//                options: .transitionFlipFromTop,
//                animations: { self.likesCount.text = self.tempCount},
//                completion: nil)
//        } else {
//            somePhotoModel?.likesCount -= 1
//            tempCount = String(somePhotoModel!.likesCount)
//            UIView.transition(
//                with: likesCount,
//                duration: 0.5,
//                options: .transitionFlipFromBottom,
//                animations: { self.likesCount.text = self.tempCount},
//                completion: nil)
//        }
    }
    
    func configure(userPhoto: PhotoData) {
        guard let imageUrlString = userPhoto.photoSizes.last?.photoURL else { return }
        self.userPic.kf.setImage(with: URL(string: imageUrlString))
        self.userPic.contentMode = .scaleAspectFill
    }
    
    func configure(userPhoto: RealmPhotos) {
        let imageUrlString = userPhoto.smallPhoto
        self.userPic.kf.setImage(with: URL(string: imageUrlString))
        self.userPic.contentMode = .scaleAspectFill
    }
    
    func config(photo: UIImage) {
        self.userPic.image = photo
        self.userPic.contentMode = .scaleAspectFill
    }
}
