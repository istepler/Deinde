//
//  PlaceCoordsVO.swift
//  DeindeApp
//
//  Created by Andrey Krit on 7/22/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import Foundation
//import ObjectMapper

struct CoordsVO: Mappable {
    var latitude: Double?
    var longtitude: Double?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        latitude <- map["latitude"]
        longtitude <- map["longtitude"]
        
    }
}
