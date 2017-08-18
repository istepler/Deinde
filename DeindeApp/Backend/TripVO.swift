//
//  TripVO.swift
//  DeindeApp
//
//  Created by Andrey Krit on 7/22/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import Foundation
import Parse


struct TripVO {
    
    var id: String?
    var title: String?
    var fullTitle: String?
    var tripDate: Date?
    var tripImage: URL?
    var imageBackground: [Int]?
    var tripFeatures: [String]?
    var duration: Int?
    var places: [PlaceVO]?
    var detailsUrl: URL?
    
    mutating func setPlaces(places: [PlaceVO]) {
        self.places = places
        
    }

}
