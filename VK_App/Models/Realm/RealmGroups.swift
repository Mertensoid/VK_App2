//
//  RealmGroups.swift
//  VK_App
//
//  Created by admin on 27.02.2022.
//

import Foundation
import RealmSwift

class RealmGroups: Object {
    @Persisted(primaryKey: true) var groupID: Int = 0
    @Persisted(indexed: true) var groupName: String = ""
    @Persisted var proupPic: String = ""
}

extension RealmGroups {
    convenience init(
        groupID: Int,
        group: GroupData) {
            self.init()
            self.groupID = groupID
            self.groupName = group.groupName
            self.proupPic = group.groupPic
        }
}

//struct GroupData {
//    let groupID: Int
//    let groupName: String
//    let groupPic: String
//}
