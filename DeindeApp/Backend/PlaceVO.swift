//
//  PlaceVO.swift
//  DeindeApp
//
//  Created by Andrey Krit on 7/22/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import Foundation
import ObjectMapper

struct PlaceVO: Mappable {
    var title: String?
    var time: String? // ???????????????
    var description: String?
    var coords: CoordsVO?
    var placeImage: URL? // or Image????
   
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        time <- map["time"]
        description <- map["description"]
        coords <- map ["coords"]
        placeImage <- map ["placeImage"]
    }
    
}
