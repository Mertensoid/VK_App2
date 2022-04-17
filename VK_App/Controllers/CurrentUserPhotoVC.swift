//
//  CurrentUserPhotoVC.swift
//  VK_App
//
//  Created by admin on 26.01.2022.
//

import UIKit
import RealmSwift
import Kingfisher

class CurrentUserPhotoVC: UIViewController {
    @IBOutlet weak var currentImageView: UIImageView!
    
    var leftImageView = UIImageView()
    var rightImageView = UIImageView()
    
    var photos: Results<RealmPhotos>?
    var currentPhotoIndex: Int = 0
    var leftPhotoIndex: Int = 0
    var rightPhotoIndex: Int = 0
    //var currentPhoto: String = ""
    
    private var propertyAnimator: UIViewPropertyAnimator!
    
    private var isAnimated = false
    private var photoService: PhotoService?
    
    private func setNewPhotos() {
        
        if let userPhotos = photos {
            
            
            if currentPhotoIndex == 0 && currentPhotoIndex != userPhotos.count-1 {
                leftPhotoIndex = userPhotos.count-1
                rightPhotoIndex = currentPhotoIndex + 1
            } else if currentPhotoIndex != 0 && currentPhotoIndex == userPhotos.count-1 {
                leftPhotoIndex = currentPhotoIndex - 1
                rightPhotoIndex = 0
            } else if userPhotos.count == 0 {
                leftPhotoIndex = currentPhotoIndex
                rightPhotoIndex = currentPhotoIndex
            } else {
                leftPhotoIndex = currentPhotoIndex - 1
                rightPhotoIndex = currentPhotoIndex + 1
            }
            
            let urlString = userPhotos[currentPhotoIndex].bigPhoto
            let leftUrlString = userPhotos[leftPhotoIndex].bigPhoto
            let rightUrlString = userPhotos[rightPhotoIndex].bigPhoto
            
            self.currentImageView.image = photoService?.photo(byURL: urlString)
            self.leftImageView.image = photoService?.photo(byURL: leftUrlString)
            self.rightImageView.image = photoService?.photo(byURL: rightUrlString)
        }
        else { return }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoService = PhotoService()
        
        setNewPhotos()
        
        leftImageView.frame.size.height = currentImageView.frame.height
        leftImageView.frame.size.width = view.bounds.width
        leftImageView.center.x = currentImageView.center.x - currentImageView.bounds.width
        leftImageView.center.y = view.center.y
        rightImageView.frame.size.height = currentImageView.frame.height
        rightImageView.frame.size.width = view.bounds.width
        rightImageView.center.x = currentImageView.center.x + currentImageView.bounds.width
        rightImageView.center.y = view.center.y

        leftImageView.contentMode = .scaleAspectFit
        rightImageView.contentMode = .scaleAspectFit

        leftImageView.isHidden = true
        rightImageView.isHidden = true
        view.addSubview(leftImageView)
        view.addSubview(rightImageView)
        
        
        currentImageView.isUserInteractionEnabled = true
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        leftImageView.isHidden = false
        rightImageView.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        leftImageView.isHidden = true
        rightImageView.isHidden = true
    }
    
    @objc
    private func didSwipe(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .right:

            self.rightImageView.center.x = self.currentImageView.center.x
            if let userPhotos = photos {
                if self.currentPhotoIndex == 0 {
                    self.currentPhotoIndex = userPhotos.count-1
                } else {
                    self.currentPhotoIndex -= 1
                }
                self.setNewPhotos()
            }
            
            self.currentImageView.bounds.size.height *= 0.1
            self.currentImageView.bounds.size.width *= 0.1
            
            UIView.animateKeyframes(
                withDuration: 0.7,
                delay: 0,
                options: [],
                animations: {
                    UIView.addKeyframe(
                        withRelativeStartTime: 0.5,
                        relativeDuration: 0.5,
                        animations: {
                            self.currentImageView.bounds.size.height /= 0.1
                        }
                    )
                    UIView.addKeyframe(
                        withRelativeStartTime: 0.5,
                        relativeDuration: 0.5,
                        animations: {
                            self.currentImageView.bounds.size.width /= 0.1
                        }
                    )
                    UIView.addKeyframe(
                        withRelativeStartTime: 0,
                        relativeDuration: 1,
                        animations: {
                            self.rightImageView.center.x = self.rightImageView.center.x + self.rightImageView.bounds.width
                        }
                    )
                },
                completion: {_ in
                    self.setNewPhotos()
                })
        
        case .left:
            
            UIView.animateKeyframes(
                withDuration: 0.7,
                delay: 0,
                options: [],
                animations: {
                    UIView.addKeyframe(
                        withRelativeStartTime: 0,
                        relativeDuration: 0.5,
                        animations: {
                            self.currentImageView.bounds.size.height *= 0.5
                        }
                    )
                    UIView.addKeyframe(
                        withRelativeStartTime: 0,
                        relativeDuration: 0.5,
                        animations: {
                            self.currentImageView.bounds.size.width *= 0.5
                        }
                    )
                    UIView.addKeyframe(
                        withRelativeStartTime: 0.5       ,
                        relativeDuration: 0.5,
                        animations: {
                            self.rightImageView.center.x = self.currentImageView.center.x
                        }
                    )
                },
                completion: {_ in
                    if let userPhotos = self.photos {
                        switch self.currentPhotoIndex {
                        case userPhotos.count-1:
                            self.currentPhotoIndex = 0
                        default:
                            self.currentPhotoIndex += 1
                        }
                        self.setNewPhotos()
                        self.rightImageView.center.x = self.rightImageView.center.x + self.rightImageView.bounds.width
                    }
                })
            
        default:
            return
        }
    }
}
