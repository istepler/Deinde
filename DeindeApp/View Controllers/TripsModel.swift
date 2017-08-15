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
    
    private (set) var allTrips: [TripVO] = []
    private (set) var freeTrips: [TripVO] = []
    
    
    func loadAllTrips(callback: @escaping (_ trips: [TripVO]?, _ error: Error?) -> ()) {
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
    
    func loadFreeTrips(callback: @escaping (_ trips: [TripVO]?, _ error: Error?) -> ()) {
        let dataLoader = DataLoader()
        dataLoader.freeTripsRequest {(trips, error) in
            if let error = error {
                print("Error occured")
                print(error)
                callback(nil, error)
            } else if let trips = trips {
                self.freeTrips = trips
            }
            callback(trips, nil)
        }
    }
    
    func loadPlacesForTrip(trip: TripVO, callback: @escaping (_ places: [PlaceVO]?, _ error: Error?) -> ()) {
        let dataLoader = DataLoader()
        dataLoader.placesForTripRequest(trip: trip) { (places, error) in
            if let error = error {
                print("Error occured")
                print(error)
                callback(nil, error)
            }
            callback(places, nil)
        }
        
    }
    
}
