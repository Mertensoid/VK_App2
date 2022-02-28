//
//  UserCollectionViewCell.swift
//  VK_App
//
//  Created by admin on 26.12.2021.
//

import UIKit

class UserPhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesCount: UILabel!
    
    var tempCount: String = ""
    
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

    var somePhotoModel: UserPhoto? = nil
    var likedVar: Bool = false
    
    func configure(userPhoto: PhotoData) {
        guard let imageUrlString = userPhoto.photoSizes.last?.photoURL else { return }
        guard let imageUrl:URL = URL(string: imageUrlString) else { return }
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else {
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: imageData){
                    self.userPic.image = image
                    self.userPic.contentMode = .scaleAspectFill
                }
            }
        }
    }
    
    func configure(userPhoto: RealmPhotos) {
        let imageUrlString = userPhoto.smallPhoto
        guard let imageUrl:URL = URL(string: imageUrlString) else { return }
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else {
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: imageData){
                    self.userPic.image = image
                    self.userPic.contentMode = .scaleAspectFill
                }
            }
        }
    }
}
