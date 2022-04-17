//
//  PhotoCollectionViewController.swift
//  VK_App
//
//  Created by admin on 22.12.2021.
//

import UIKit
import RealmSwift

class PhotoCollectionViewController: UICollectionViewController {

    //MARK: - Private properties
    private let networkService = NetworkService()
    private var userPhotos: Results<RealmPhotos>?
    private var currentPhotoIndex: Int = 0
    private var photoToken: NotificationToken?
    private var photoService: PhotoService?
    
    //MARK: - Public properties
    var user: Int = 0
    
    //MARK: - Private methods
    private func reloadPhotos() {
        userPhotos = try? RealmService.load(typeOf: RealmPhotos.self).filter(NSPredicate(
                format: "ownerID == %@",
                NSNumber(value: user)))
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        photoService = PhotoService(container: collectionView)
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        photoToken = userPhotos?.observe { [weak self] userPhotoChanges in
            guard let self = self else { return }
            switch userPhotoChanges {
            case .initial:
                self.collectionView.reloadData()
            case .update(
                _,
                deletions: let deletions,
                insertions: let insertions,
                modifications: let modifications):
                self.collectionView.performBatchUpdates {
                    let deleteIndex = deletions.map { IndexPath(
                        row: $0,
                        section: 0) }
                    let insertIndex = insertions.map { IndexPath(
                        row: $0,
                        section: 0) }
                    let modificationIndex = modifications.map { IndexPath(
                        row: $0,
                        section: 0) }
                    self.collectionView.deleteItems(
                        at: deleteIndex)
                    self.collectionView.insertItems(
                        at: insertIndex)
                    self.collectionView.reloadItems(
                        at: modificationIndex)
                } completion: { _ in
                    self.collectionView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        photoToken?.invalidate()
    }

    //MARK: - Segue data source
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
        let photo = photoService?.photo(atIndexPath: indexPath, byURL: userPhoto.smallPhoto)
        cell.config(photo: photo ?? UIImage())
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentPhotoIndex = indexPath.item
        performSegue(withIdentifier: "goToCurrentPhoto", sender: nil)
    }
}
