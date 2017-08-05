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
    
    
    
    func loadTrips(callback: @escaping () -> ()) {
        let dataLoader = DataLoader()
        dataLoader.allTripsRequest {[weak self] (trips, error) in
            if let error = error {
                print("Error occured")
                print(error)
            } else if let trips = trips {
                self?.allTrips = trips
                callback()
            }
        }
    }
    
    
    
    
    
}
