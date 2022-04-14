//
//  GroupModel.swift
//  VK_App
//
//  Created by admin on 26.12.2021.
//

import Foundation
import UIKit

func generateMyGroups() -> [Group] {
    var myGroups: [Group] = []
    myGroups.append(Group(
        groupName: "Gamers Party",
        groupPic: UIImage(named: "essentials-2")!))
    myGroups.append(Group(
        groupName: "Some Group",
        groupPic: UIImage(named: "essentials-3")!))
    myGroups.append(Group(
        groupName: "Another Group",
        groupPic: UIImage(named: "essentials-4")!))
    myGroups.append(Group(
        groupName: "One more Group",
        groupPic: UIImage(named: "essentials-5")!))
    myGroups.append(Group(
        groupName: "Last Group",
        groupPic: UIImage(named: "essentials-6")!))
    return myGroups
}

struct Group: Equatable {
    let groupName: String
    let groupPic: UIImage
}
