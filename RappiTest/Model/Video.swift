//
//  Video.swift
//  RappiTest
//
//  Created by MAC on 3/5/19.
//  Copyright © 2019 Andres Marin. All rights reserved.
//
import Foundation
import ObjectMapper


class VideoResponse : Mappable{
    
    var videResults:[VideoResults] = []
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        //mapping the keys according the json
        videResults <- map["results"]
    }
    
}

class VideoResults : Mappable{
    
    var id: Int?
    var key: String?
    var name: String?
    var type: String?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        //mapping the keys according the json
        id <- map["id"]
        key <- map["key"]
        name <- map["name"]
        type <- map["type"]
    }
    
}


