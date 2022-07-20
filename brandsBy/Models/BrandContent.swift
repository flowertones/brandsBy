//
//  Models.swift
//  brandsBy
//
//  Created by Alina Karpovich on 19.06.22.
//

import Foundation
import ObjectMapper

class BrandContent: Mappable, CustomDebugStringConvertible {
    
    var id = 0
    var name = ""
    var image = ""
    var shops: [Shops]?
    var description: String?
    var instagram: String?
    var website: String?
    var tg: String?
    var categories = [String]()
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        image <- map["image"]
        shops <- map["shops"]
        description <- map["description"]
        instagram <- map["instagram"]
        website <- map["website"]
        tg <- map["tg"]
        categories <- map["categories"]
    }
    
    var debugDescription: String {
        return "\(name)\n"
    }
}

class Shops: Mappable {
    var city: String?
    var address: String?
    var hours: String?
    var latitude: Double?
    var longitude: Double?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        city <- map["city"]
        address <- map["address"]
        hours <- map["hours"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }
}
