//
//  PhotoCollectionViewController.swift
//  VK_App
//
//  Created by admin on 22.12.2021.
//

import UIKit

//private let reuseIdentifier = "Cell"

class PhotoCollectionViewController: UICollectionViewController {

    var photos: [UIImage?] = [
        UIImage(named: "summer-1"),
        UIImage(named: "summer-2"),
        UIImage(named: "summer-3"),
        UIImage(named: "summer-4"),
        UIImage(named: "summer-5"),
        UIImage(named: "summer-6"),
        UIImage(named: "summer-7"),
        UIImage(named: "summer-8"),
        UIImage(named: "summer-9"),
        UIImage(named: "summer-10"),
        UIImage(named: "summer-11"),
        UIImage(named: "summer-12"),
        UIImage(named: "summer-13"),
        UIImage(named: "summer-14"),
        UIImage(named: "summer-15"),
        UIImage(named: "summer-16"),
        UIImage(named: "summer-17"),
        UIImage(named: "summer-18"),
        UIImage(named: "summer-19"),
        UIImage(named: "summer-20"),
        UIImage(named: "summer-21"),
        UIImage(named: "summer-22"),
        UIImage(named: "summer-23"),
        UIImage(named: "summer-24"),
        UIImage(named: "summer-25")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(
            UINib(
                nibName: "UserPhotoCollectionViewCell",
                bundle: nil),
            forCellWithReuseIdentifier: "userPhotoCollectionViewCell")

    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userPhotoCollectionViewCell", for: indexPath) as? UserPhotoCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        cell.configure(userPhoto: photos[indexPath.row]!)
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
