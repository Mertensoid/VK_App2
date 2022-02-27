//
//  RealmFriends.swift
//  VK_App
//
//  Created by admin on 27.02.2022.
//

import Foundation
import RealmSwift

class RealmFriends: Object {
    @Persisted(primaryKey: true) var friendID: Int = 0
    @Persisted var name: String = ""
    @Persisted var surName: String = ""
    @Persisted var friendPhoto: String = ""
}

extension RealmFriends {
    convenience init(
        friendID: Int,
        friend: FriendData) {
            self.init()
            self.friendID = friendID
            self.name = friend.name
            self.surName = friend.surName
            self.friendPhoto = friend.friendPhoto
        }
}


//struct FriendData {
//    let friendID: Int
//    let name: String
//    let surName: String
//    let friendPhoto: String
//    //let birthDate: String
//}
