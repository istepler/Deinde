//
//  DataLoader.swift
//  DeindeApp
//
//  Created by Andrey Krit on 8/5/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import Foundation
import Parse

class DataLoader {
    
    func allTripsRequest(callback: @escaping (_ trips: [TripVO]?, _ error: Error?) -> ()) {
        let query = PFQuery(className: "TripVO").whereKey("freeTrip", equalTo: false)
        query.findObjectsInBackground { (objects, error) in
            if let error = error {
                // TODO: handle error
                callback(nil, error)
            } else if let objects = objects {
                let trips = objects.map { object -> TripVO in
                    TripVO(
                        tourId:           object.value(forKey: "id") as? String,
                        title:            object.value(forKey: "title") as? String,
                        fullTitle:        object.value(forKey: "fullTitle") as? String,
                        tripDate:         object.value(forKey: "date") as? Date,
                        tripImage:        object.value(forKey: "imageTrip") as? URL,
                        imagebBackground: object.value(forKey: "backgroundTrip") as? [Int],
                        tripFeatures:     object.value(forKey: "listFeaturesTrip") as? [String],
                        duration:         object.value(forKey: "duration")  as? Int)
                }
                 callback(trips, nil)
            }
           
        }
    }
    
    
    func freeTripsRequest(callback: @escaping (_ trips: [TripVO]?, _ error: Error?) -> ()) {
        let query = PFQuery(className: "TripVO").whereKey("freeTrip", equalTo: false)
        query.findObjectsInBackground { (objects, error) in
            if let error = error {
                // TODO: handle error
                callback(nil, error)
            } else if let objects = objects {
                let trips = objects.map { object -> TripVO in
                    TripVO(
                        tourId:           object.value(forKey: "id") as? String,
                        title:            object.value(forKey: "title") as? String,
                        fullTitle:        object.value(forKey: "fullTitle") as? String,
                        tripDate:         object.value(forKey: "date") as? Date,
                        tripImage:        object.value(forKey: "imageTrip") as? URL,
                        imagebBackground: object.value(forKey: "backgroundTrip") as? [Int],
                        tripFeatures:     object.value(forKey: "listFeaturesTrip") as? [String],
                        duration:         object.value(forKey: "duration")  as? Int)
                }
                callback(trips, nil)
            }
            
        }
    }
}
