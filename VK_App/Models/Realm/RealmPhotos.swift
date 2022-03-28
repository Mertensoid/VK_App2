//
//  RealmPhotos.swift
//  VK_App
//
//  Created by admin on 27.02.2022.
//

import Foundation
import RealmSwift



class RealmPhotos: Object {
    @Persisted(primaryKey: true) var photoID: Int = 0
    @Persisted var ownerID: Int = 0
    @Persisted var smallPhoto: String = ""
    @Persisted var bigPhoto: String = ""
}

extension RealmPhotos {
    convenience init(
        photo: PhotoData) {
            self.init()
            self.photoID = photo.photoID
            self.ownerID = photo.ownerID
            if let photoURLString = photo.photoSizes.first?.photoURL {
                self.smallPhoto = photoURLString
            }
            if let photoURLString = photo.photoSizes.last?.photoURL {
                self.bigPhoto = photoURLString
            }
        }
}
    
//    struct PhotoData {
//        let photoID: Int
//        let ownerID: Int
//        let photo: [PhotoSize]
//    }
