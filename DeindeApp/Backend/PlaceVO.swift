//
//  PlaceVO.swift
//  DeindeApp
//
//  Created by Andrey Krit on 7/22/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import Foundation
import ObjectMapper

struct PlaceVO {
    
    var id: String?
    var title: String?
    var time: Int? // ???????????????
    var day: Int?
    var description: String?
    var coords: CoordsVO?
    var placeImage: URL? // or Image????
   
}
