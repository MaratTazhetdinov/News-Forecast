//
//  News.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 14.11.2021.
//

import Foundation


struct NewsResponse: Codable {
    struct Error: Codable {
        let code: String
        let message: String
    }
    
    let error: Error?
    let data: [News]?
}

struct News: Codable {
//    var author: String
    var title: String
    var description: String
//    var image: URL
//    var category: String
//    var published_at: String

//    enum CodingKeys: String, CodingKey {
//        case title
//        case description
//        case image
//        case category
//        case published = "published_at"
//    }
}
