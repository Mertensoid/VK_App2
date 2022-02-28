//
//  PhotoCollectionViewController.swift
//  VK_App
//
//  Created by admin on 22.12.2021.
//

import UIKit
import RealmSwift

class PhotoCollectionViewController: UICollectionViewController {

    private let networkService = NetworkService()
    private var userPhotos: Results<RealmPhotos>?
    var user: Int = 0
    private var currentPhotoIndex: Int = 0
    
    func reloadPhotos() {
        userPhotos = try? RealmService.load(typeOf: RealmPhotos.self).filter(NSPredicate(
                format: "ownerID == %@",
                NSNumber(value: user)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadPhotos()
        
        let urlQI = URLQueryItem(name: "owner_id", value: String(self.user))
        networkService.fetchPhotos(urlQI: urlQI) { [weak self] result in
            switch result {
            case .success(let photos):
                let realmPhotos = photos.map {
                    RealmPhotos(photo: $0)
                }
                DispatchQueue.main.async {
                    do {
                        try RealmService.save(items: realmPhotos)
                        self?.reloadPhotos()
                        self?.collectionView.reloadData()
                    } catch {
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        
        self.collectionView!.register(
            UINib(
                nibName: "UserPhotoCollectionViewCell",
                bundle: nil),
            forCellWithReuseIdentifier: "userPhotoCollectionViewCell")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "goToCurrentPhoto" else { return }
        guard let destination = segue.destination as? CurrentUserPhotoVC else { return }
        destination.currentPhotoIndex = currentPhotoIndex
        if let photos = self.userPhotos {
            destination.photos = photos
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPhotos?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let userPhoto = userPhotos?[indexPath.item],
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userPhotoCollectionViewCell", for: indexPath) as? UserPhotoCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        cell.configure(userPhoto: userPhoto)
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentPhotoIndex = indexPath.item
        performSegue(withIdentifier: "goToCurrentPhoto", sender: nil)
    }
}
