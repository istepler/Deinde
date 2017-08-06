//
//  TripsModel.swift
//  DeindeApp
//
//  Created by Andrey Krit on 8/5/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import Foundation

class TripsModel {
    
    static var instance = TripsModel()
    
    var allTrips: [TripVO] = []
    private(set) var freeTrips: [TripVO] = []
    
    
    
    func loadTrips(callback: @escaping (_ trips: [TripVO]?, _ error: Error?) -> ()) {
        let dataLoader = DataLoader()
        dataLoader.allTripsRequest {(trips, error) in
            if let error = error {
                print("Error occured")
                print(error)
                callback(nil, error)
            } else if let trips = trips {
                self.allTrips = trips
                }
            callback(trips, nil)
        }
    }
    
    
    
    
    
}