//
//  Credits.swift
//  RappiTest
//
//  Created by MAC on 3/5/19.
//  Copyright © 2019 Andres Marin. All rights reserved.
//
import Foundation
import ObjectMapper

class CreditsResponse : Mappable{
    
    var cast:[Cast] = []
    var crew:[Crew] = []

    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        //mapping the keys according the json
        cast <- map["cast"]
        crew <- map["crew"]
    }
    
}

class Cast : Mappable{
    
    var castId: Int?
    var name: String?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        //mapping the keys according the json
        castId <- map["cast_id"]
        name <- map["name"]
    }
    
}

class Crew : Mappable{
    
    var creditId: Int?
    var job: String?
    var name: String?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        //mapping the keys according the json
        creditId <- map["credit_id"]
        job <- map["job"]
        name <- map["name"]
    }
    
}

