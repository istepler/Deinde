//
//  UserVO.swift
//  DeindeApp
//
//  Created by Andrey Krit on 7/22/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import Foundation
import ObjectMapper

struct UserVO: Mappable {
    
    var token: String? // what comes from firebaase
    var id: Int?
    var firstName: String?
    var secondName: String?
    var email: String?
    var facebook: String?
    var avatar: URL?
    var description: String?
    var userTours: [TripVO]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        //id <- map["id"]
        firstName <- map ["firstName"]
        secondName <- map["secondName"]
        email <- map["email"]
        facebook <- map["facebook"]
        avatar <- map["avatar"]
        description <- map["description"]
        userTours <- map["userTours"]
        
    }
    
}
