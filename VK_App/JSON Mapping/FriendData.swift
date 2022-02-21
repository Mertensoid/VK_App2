//
//  UserData.swift
//  VK_App
//
//  Created by admin on 19.02.2022.
//

struct FriendData {
    let friendID: Int
    let name: String
    let surName: String
    //let birthDate: String
}

extension FriendData: Codable {
    enum CodingKeys: String, CodingKey {
        case friendID = "id"
        case name = "first_name"
        case surName = "last_name"
        //case birthDate = "bdate"
    }
}


//Optional({
//    response =     {
//        count = 117;
//        items =         (
//                        {
//                bdate = "1.2";
//                "can_access_closed" = 1;
//                "first_name" = Alexander;
//                id = 2917353;
//                "is_closed" = 1;
//                "last_name" = Vorontsov;
//                "track_code" = 1434fbd0Qd63V8AVDNipf5QMrbzSmU5AYpALy9DQY7UOW6wHa1cgvdNmwhUJ16x5p4kLTYDgTUAL9Q;
//            },
