//
//  newsData.swift
//  miniSportApp
//
//  Created by Joanne Monaghan on 04/10/2023.
//

import UIKit

struct Top: Codable {
    var data: Data
}

struct Data: Codable {
    var topic: Topic
    var items: [Items]
}

struct Topic: Codable {
    var title: String
    var url: String
    
}


struct Items: Codable {
    var type: String
    var title: String
    var url: String
    var sectionLabel: String
    var sectionUrl: String
    var isLive: Bool
    var lastUpdatedTimestamp: Int
    var image: Image
}

struct Image: Codable {
    var small: String
    var medium: String
    var large: String
    var altText: String
    var copyrightHolder: String
}





/*
struct TopicData: Codable {
    var title: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case url = "url"
    }
    
}


struct ItemData: Codable {
//            struct ImageData: Codable {
//                var small: String
//                var medium: String
//                var large: String
//                var altText: String
//                var copyrightHolder: String
//
//            }
    var type: String
//            var title: String
//            var url: String
//            var sectionLabel: String
//            var isLive: Bool
//            var lastUpdatedText: String
//        //    var mediaType: NSNull
//          //  var contentType: NSNull
//            var lastUpdatedTimestamp: Int
//            var image: ImageData

    enum CodingKeys: String, CodingKey {
        case type = "type"
    }
}

var topic: TopicData
var items: [ItemData]

enum CodingKeys: String, CodingKey {
    case topic = "topic"
    case items = "items"
}

struct NewsData: Codable {
    
//    struct DataData: Codable {
       
        
  
//    }
    
//    init() {
//        
//    }
//    var data: DataData
//    
//    enum CodingKeys: String, CodingKey {
//        case data = "data"
//    }
}

*/


