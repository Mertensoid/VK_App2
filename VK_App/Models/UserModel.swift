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
            UserPhoto(photo: UIImage(named: "summer-1")!, liked: false),
            UserPhoto(photo: UIImage(named: "summer-2")!, liked: false),
            UserPhoto(photo: UIImage(named: "summer-3")!, liked: false),
            UserPhoto(photo: UIImage(named: "summer-4")!, liked: false),
            UserPhoto(photo: UIImage(named: "summer-5")!, liked: false)
        ]))
    myFriends.append(User(
        userName: "Second Friend",
        avatarPic: UIImage(named: "cook_icon_128x128")!,
        userPhotos: [
            UserPhoto(photo: UIImage(named: "summer-6")!, liked: false),
            UserPhoto(photo: UIImage(named: "summer-7")!, liked: false),
            UserPhoto(photo: UIImage(named: "summer-8")!, liked: false),
            UserPhoto(photo: UIImage(named: "summer-9")!, liked: false),
            UserPhoto(photo: UIImage(named: "summer-10")!, liked: false)
        ]))
    myFriends.append(User(
        userName: "Third Friend",
        avatarPic: UIImage(named: "farmer_icon_128x128")!,
        userPhotos: [
            UserPhoto(photo: UIImage(named: "summer-11")!, liked: false),
            UserPhoto(photo: UIImage(named: "summer-12")!, liked: false),
            UserPhoto(photo: UIImage(named: "summer-13")!, liked: false),
            UserPhoto(photo: UIImage(named: "summer-14")!, liked: false),
            UserPhoto(photo: UIImage(named: "summer-15")!, liked: false)
        ]))
    myFriends.append(User(
        userName: "Fourth Friend",
        avatarPic: UIImage(named: "nurse_icon_128x128")!,
        userPhotos: [
            UserPhoto(photo: UIImage(named: "summer-16")!, liked: false),
            UserPhoto(photo: UIImage(named: "summer-17")!, liked: false),
            UserPhoto(photo: UIImage(named: "summer-18")!, liked: false),
            UserPhoto(photo: UIImage(named: "summer-19")!, liked: false),
            UserPhoto(photo: UIImage(named: "summer-20")!, liked: false)
        ]))
    myFriends.append(User(
        userName: "Fifth Friend",
        avatarPic: UIImage(named: "worker_icon_128x128")!,
        userPhotos: [
            UserPhoto(photo: UIImage(named: "summer-21")!, liked: false),
            UserPhoto(photo: UIImage(named: "summer-22")!, liked: false),
            UserPhoto(photo: UIImage(named: "summer-23")!, liked: false),
            UserPhoto(photo: UIImage(named: "summer-24")!, liked: false),
            UserPhoto(photo: UIImage(named: "summer-25")!, liked: false)
        ]))
    return myFriends
}

struct User {
    let userName: String
    let avatarPic: UIImage
    
    let userPhotos: [UserPhoto]
}

struct UserPhoto {
    let photo: UIImage
    var liked: Bool
}

