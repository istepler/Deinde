//
//  PlaceVO.swift
//  DeindeApp
//
//  Created by Andrey Krit on 7/22/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import Foundation
import CoreLocation

struct PlaceVO {
    
    var id: String?
    var title: String?
    var time: Int? // ???????????????
    var day: Int?
    var description: String?
    var coords: PFGeoPoint?
    var placeImage: URL? // or Image????
   
}

import Parse

extension PFGeoPoint {
    
    func location() -> CLLocation {
        return CLLocation(latitude: self.latitude, longitude: self.longitude)
    }
}
