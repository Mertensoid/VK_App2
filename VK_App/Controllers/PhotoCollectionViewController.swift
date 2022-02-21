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
    var userPhotos: [PhotoData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.collectionView!.register(
            UINib(
                nibName: "UserPhotoCollectionViewCell",
                bundle: nil),
            forCellWithReuseIdentifier: "userPhotoCollectionViewCell")
        
        networkService.fetchPhotos() { [weak self] result in
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
        
        guard let imageUrlString = userPhotos[indexPath.item].photoSizes.last?.photoURL else { return UICollectionViewCell() }
        guard let imageUrl:URL = URL(string: imageUrlString) else { return UICollectionViewCell() }
        
        // Start background thread so that image loading does not make app unresponsive
        DispatchQueue.global().async { [weak self] in
            
            guard let self = self else { return }
            
            guard let imageData = try? Data(contentsOf: imageUrl) else {
                return
            }
            
            // When from a background thread, UI needs to be updated on main_queue
            DispatchQueue.main.async {
                if let image = UIImage(data: imageData){
                    cell.configure(userPhoto: image, likesCounter: 0, liked: false)
                }
                
            }
        }
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
