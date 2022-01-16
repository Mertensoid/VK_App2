//
//  UserModel.swift
//  VK_App
//
//  Created by admin on 26.12.2021.
//

import Foundation
import UIKit

func generateMyFriends() -> [User] {
    var myFriends: [User] = []
    myFriends.append(User(
        userName: "First Friend",
        avatarPic: UIImage(named: "buisness_woman_icon_128x128")!,
        userPhotos: [
            UIImage(named: "summer-1")!,
            UIImage(named: "summer-2")!,
            UIImage(named: "summer-3")!,
            UIImage(named: "summer-4")!,
            UIImage(named: "summer-5")!,
        ]))
    myFriends.append(User(
        userName: "Second Friend",
        avatarPic: UIImage(named: "cook_icon_128x128")!,
        userPhotos: [
            UIImage(named: "summer-6")!,
            UIImage(named: "summer-7")!,
            UIImage(named: "summer-8")!,
            UIImage(named: "summer-9")!,
            UIImage(named: "summer-10")!,
        ]))
    myFriends.append(User(
        userName: "Third Friend",
        avatarPic: UIImage(named: "farmer_icon_128x128")!,
        userPhotos: [
            UIImage(named: "summer-11")!,
            UIImage(named: "summer-12")!,
            UIImage(named: "summer-13")!,
            UIImage(named: "summer-14")!,
            UIImage(named: "summer-15")!,
        ]))
    myFriends.append(User(
        userName: "Fourth Friend",
        avatarPic: UIImage(named: "nurse_icon_128x128")!,
        userPhotos: [
            UIImage(named: "summer-16")!,
            UIImage(named: "summer-17")!,
            UIImage(named: "summer-18")!,
            UIImage(named: "summer-19")!,
            UIImage(named: "summer-20")!,
        ]))
    myFriends.append(User(
        userName: "Fifth Friend",
        avatarPic: UIImage(named: "worker_icon_128x128")!,
        userPhotos: [
            UIImage(named: "summer-21")!,
            UIImage(named: "summer-22")!,
            UIImage(named: "summer-23")!,
            UIImage(named: "summer-24")!,
            UIImage(named: "summer-25")!,
        ]))
    return myFriends
}

struct User {
    var userName: String
    var avatarPic: UIImage
    
    var userPhotos: [UIImage]
}


