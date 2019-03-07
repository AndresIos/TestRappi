//
//  Genres.swift
//  RappiTest
//
//  Created by MAC on 3/5/19.
//  Copyright © 2019 Andres Marin. All rights reserved.
//
import Foundation
import ObjectMapper

class Genres : Mappable{
    
    var id: Int?
    var name: String?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        //mapping the keys according the json
        id <- map["id"]
        name <- map["name"]
    }
    
}
