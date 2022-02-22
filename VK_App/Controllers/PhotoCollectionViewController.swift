//
//  PhotoCollectionViewController.swift
//  VK_App
//
//  Created by admin on 22.12.2021.
//

import UIKit

//private let reuseIdentifier = "Cell"

class PhotoCollectionViewController: UICollectionViewController {

    let networkService = NetworkService()
    var user: Int = 0
    var currentPhotoIndex: Int = 0
    var userPhotos: [PhotoData] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.user)
        self.collectionView!.register(
            UINib(
                nibName: "UserPhotoCollectionViewCell",
                bundle: nil),
            forCellWithReuseIdentifier: "userPhotoCollectionViewCell")
        
        let urlQI = URLQueryItem(name: "owner_id", value: String(self.user))
        networkService.fetchPhotos(urlQI: urlQI) { [weak self] result in
            
            switch result {
            case .success(let photos):
                self?.userPhotos = photos
            case .failure(let error):
                print(error)
            }
        }
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
        //destination.photos = userPhotos
        destination.currentPhotoIndex = currentPhotoIndex
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userPhotoCollectionViewCell", for: indexPath) as? UserPhotoCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.configure(userPhoto: userPhotos[indexPath.item])
        //
    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let user = user {
//            userPhotos = getPhotos(user: user)
//        }
        currentPhotoIndex = indexPath.item
        performSegue(withIdentifier: "goToCurrentPhoto", sender: nil)
    }
}
