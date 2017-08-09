//
//  TripVO.swift
//  DeindeApp
//
//  Created by Andrey Krit on 7/22/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import Foundation
import ObjectMapper


struct TripVO {
    
    var id: String?
    var title: String?
    var fullTitle: String?
    var tripDate: Date?
    var tripImage: URL?
    var imagebBackground: [Int]?
    var tripFeatures: [String]?
    var duration: Int?
    var places: [PlaceVO]?
    
    mutating func setPlaces(places: [PlaceVO]) {
        self.places = places
    }

}
