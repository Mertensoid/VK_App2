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
            UserPhoto(photo: UIImage(named: "summer-1")!, likesCount: 0, liked: false),
            UserPhoto(photo: UIImage(named: "summer-2")!, likesCount: 0, liked: false),
            UserPhoto(photo: UIImage(named: "summer-3")!, likesCount: 0, liked: false),
            UserPhoto(photo: UIImage(named: "summer-4")!, likesCount: 0, liked: false),
            UserPhoto(photo: UIImage(named: "summer-5")!, likesCount: 0, liked: false)
        ]))
    myFriends.append(User(
        userName: "Second Friend",
        avatarPic: UIImage(named: "cook_icon_128x128")!,
        userPhotos: [
            UserPhoto(photo: UIImage(named: "summer-6")!, likesCount: 0, liked: false),
            UserPhoto(photo: UIImage(named: "summer-7")!, likesCount: 0, liked: false),
            UserPhoto(photo: UIImage(named: "summer-8")!, likesCount: 0, liked: false),
            UserPhoto(photo: UIImage(named: "summer-9")!, likesCount: 0, liked: false),
            UserPhoto(photo: UIImage(named: "summer-10")!, likesCount: 0, liked: false)
        ]))
    myFriends.append(User(
        userName: "Third Friend",
        avatarPic: UIImage(named: "farmer_icon_128x128")!,
        userPhotos: [
            UserPhoto(photo: UIImage(named: "summer-11")!, likesCount: 0, liked: false),
            UserPhoto(photo: UIImage(named: "summer-12")!, likesCount: 0, liked: false),
            UserPhoto(photo: UIImage(named: "summer-13")!, likesCount: 0, liked: false),
            UserPhoto(photo: UIImage(named: "summer-14")!, likesCount: 0, liked: false),
            UserPhoto(photo: UIImage(named: "summer-15")!, likesCount: 0, liked: false)
        ]))
    myFriends.append(User(
        userName: "Fourth Friend",
        avatarPic: UIImage(named: "nurse_icon_128x128")!,
        userPhotos: [
            UserPhoto(photo: UIImage(named: "summer-16")!, likesCount: 0, liked: false),
            UserPhoto(photo: UIImage(named: "summer-17")!, likesCount: 0, liked: false),
            UserPhoto(photo: UIImage(named: "summer-18")!, likesCount: 0, liked: false),
            UserPhoto(photo: UIImage(named: "summer-19")!, likesCount: 0, liked: false),
            UserPhoto(photo: UIImage(named: "summer-20")!, likesCount: 0, liked: false)
        ]))
    myFriends.append(User(
        userName: "Fifth Friend",
        avatarPic: UIImage(named: "worker_icon_128x128")!,
        userPhotos: [
            UserPhoto(photo: UIImage(named: "summer-21")!, likesCount: 0, liked: false),
            UserPhoto(photo: UIImage(named: "summer-22")!, likesCount: 0, liked: false),
            UserPhoto(photo: UIImage(named: "summer-23")!, likesCount: 0, liked: false),
            UserPhoto(photo: UIImage(named: "summer-24")!, likesCount: 0, liked: false),
            UserPhoto(photo: UIImage(named: "summer-25")!, likesCount: 0, liked: false)
        ]))
    return myFriends
}

struct User {
    let userName: String
    let avatarPic: UIImage
    
    var userPhotos: [UserPhoto]
}

struct UserPhoto {
    let photo: UIImage
    var likesCount: Int
    var liked: Bool
}

