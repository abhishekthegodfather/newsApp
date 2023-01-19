//
//  newsModels.swift
//  newsApp
//
//  Created by Cubastion on 19/01/23.
//

import Foundation

struct newsArticles : Codable {
    var articles : [Article]
}

struct Article : Codable {
    var author : String?
    var title : String?
    var description : String?
    var url : String?
    var urlToImage : String?
    var publishedAt : String?
    var source : Source
}

struct Source : Codable {
    var name : String
}
