//
//  RealmPhotos.swift
//  VK_App
//
//  Created by admin on 27.02.2022.
//

import Foundation
import RealmSwift



class RealmPhotos: Object {
    @Persisted var photoID: Int = 0
    @Persisted var ownerID: Int = 0
    @Persisted var photo: String = ""
}

extension RealmPhotos {
    convenience init(
        photoID: Int,
        photo: PhotoData) {
            self.init()
            self.photoID = photoID
            self.ownerID = photo.ownerID
            if let photoURLString = photo.photoSizes.last?.photoURL {
                self.photo = photoURLString
            }
        }
}
    
//    struct PhotoData {
//        let photoID: Int
//        let ownerID: Int
//        let photo: [PhotoSize]
//    }
