//
//  Movie.swift
//  RappiTest
//
//  Created by Andres Marin on 3/3/19.
//  Copyright © 2019 Andres Marin. All rights reserved.
//

import Foundation
import ObjectMapper

enum movieCategory:String {
    case popular = "popular"
    case upcoming = "upcoming"
    case top_rated = "top_rated"
}
class MovieResponse : Mappable{
    
    var id: Int?
    var title: String?
    var poster_path: String?
    var original_title: String?
    var overview: String?
    var release_date: String?
    var backdrop_path:String?
    var average:NSNumber?
    var runtime:Int?
    var genres:[Genres] = []
    var videoResponse:VideoResponse?
    var creditsResponse:CreditsResponse?
    
    required init?(map: Map) {
       
    }
    func mapping(map: Map) {
        //mapping the keys according the json
        id <- map["id"]
        title <- map["title"]
        poster_path <- map["poster_path"]
        original_title <- map["original_title"]
        release_date <- map["release_date"]
        overview <- map["overview"]
        backdrop_path <- map["backdrop_path"]
        average <- map["vote_average"]
        genres <- map["genres"]
        videoResponse <- map["videos"]
        runtime <- map["runtime"]
        creditsResponse <- map["credits"]
    }
    
}

class Movie{
    
    var id: Int?
    var title: String?
    var poster_path: String?
    var original_title: String?
    var overview: String?
    var release_date: String?
    var backdrop_path:String?
    var average:NSNumber?
    var runtime:Int?
    var genres:[Genres] = []
    var videoResponse:VideoResponse?
    var creditsResponse:CreditsResponse?
}


