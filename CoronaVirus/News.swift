//
//  News.swift
//  CoronaVirus
//
//  Created by User01 on 2021/1/9.
//

import Foundation

struct News: Decodable{
    var articles:[article]
    struct article: Decodable{
        var source : Source
        var author : String?
        var title: String
        var description: String
        var url: URL
        var urlToImage: URL
        var publishedAt: String
    }
    
}

struct Source:Decodable{
    var name:String
}
