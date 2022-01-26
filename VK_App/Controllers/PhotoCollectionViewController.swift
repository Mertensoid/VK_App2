//
//  PhotoCollectionViewController.swift
//  VK_App
//
//  Created by admin on 22.12.2021.
//

import UIKit

//private let reuseIdentifier = "Cell"

class PhotoCollectionViewController: UICollectionViewController {

    var user: User? = nil
    var currentPhotoIndex: Int = 0
    var userPhotos: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(
            UINib(
                nibName: "UserPhotoCollectionViewCell",
                bundle: nil),
            forCellWithReuseIdentifier: "userPhotoCollectionViewCell")

    }

    func getPhotos(user: User) -> [UIImage] {
        let userPhotos = user.userPhotos
        var photos: [UIImage] = []
        for i in userPhotos {
            photos.append(i.photo)
        }
        return photos
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "goToCurrentPhoto" else { return }
        guard let destination = segue.destination as? CurrentUserPhotoVC else { return }
        destination.photos = userPhotos
        destination.currentPhotoIndex = currentPhotoIndex
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user?.userPhotos.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userPhotoCollectionViewCell", for: indexPath) as? UserPhotoCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        cell.configure(userPhoto: user?.userPhotos[indexPath.row] ?? UserPhoto(photo: UIImage(), likesCount: 0, liked: false))
    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let user = user {
            userPhotos = getPhotos(user: user)
        }
        currentPhotoIndex = indexPath.item
        performSegue(withIdentifier: "goToCurrentPhoto", sender: nil)
    }
}
