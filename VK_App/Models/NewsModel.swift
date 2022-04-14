//
//  NewsModel.swift
//  VK_App
//
//  Created by admin on 18.01.2022.
//

import Foundation
import UIKit

struct NewsPost {
    var title: String = ""
    var author: String = ""
    var authorPicture: UIImage? = nil
    var postTime: String = ""
    var picture: UIImage? = nil
    var viewsCount: Int = 0
    var newsText: String = ""
}

var newsModel: [NewsPost] = [
    NewsPost(title: "Голикова объявила о сокращении срока карантина по коронавирусу до семи дней",
             author: "Голикова",
             authorPicture: UIImage(named: "essentials-23"),
             postTime: "Today 10:15:33 AM",
             picture: UIImage(named: "756425082722321"),
             viewsCount: 0,
             newsText: "Власти будут наблюдать за ситуацией и готовы снова изменить срок карантина, если это будет необходимо, сообщила Голикова"),
    NewsPost(title: "Премьер-министр Мишустин призвал работодателей перевести персонал на удаленную работу",
             author: "Мишустин",
             authorPicture: UIImage(named: "essentials-24"),
             postTime: "Yesterday 11:48:33 PM",
             picture: UIImage(named: "ofis"),
             viewsCount: 0,
             newsText: "Премьер-министр Михаил Мишустин на заседании координационного совета по борьбе с COVID-19 призвал работодателей по возможности перевести персонал на удаленную работу и обеспечить вакцинацию сотрудников, работающих в офисах."),
]
