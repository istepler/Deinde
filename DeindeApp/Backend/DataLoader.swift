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
                        id:               object.value(forKey: "id") as? String,
                        title:            object.value(forKey: "title") as? String,
                        fullTitle:        object.value(forKey: "fullTitle") as? String,
                        tripDate:         object.value(forKey: "date") as? Date,
                        tripImage:        object.value(forKey: "imageTrip") as? URL,
                        imagebBackground: object.value(forKey: "backgroundTrip") as? [Int],
                        tripFeatures:     object.value(forKey: "listFeaturesTrip") as? [String],
                        duration:         object.value(forKey: "duration")  as? Int,
                        places: object.value(forKey: "places")  as? [PlaceVO])
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
                        id:               object.value(forKey: "objectId") as? String,
                        title:            object.value(forKey: "title") as? String,
                        fullTitle:        object.value(forKey: "fullTitle") as? String,
                        tripDate:         object.value(forKey: "date") as? Date,
                        tripImage:        object.value(forKey: "imageTrip") as? URL,
                        imagebBackground: object.value(forKey: "backgroundTrip") as? [Int],
                        tripFeatures:     object.value(forKey: "listFeaturesTrip") as? [String],
                        duration:         object.value(forKey: "duration")  as? Int,
                        places: object.value(forKey: "places")  as? [PlaceVO])
                }
                callback(trips, nil)
            }
        }
    }
    
    func placesForTripRequest(trip: TripVO, callback: @escaping (_ places: [PlaceVO]?, _ error: Error?) -> ()) {
        if let tripId = trip.id {
            let tripPointer = PFObject(withoutDataWithClassName: "TripVO", objectId: tripId)
            let query = PFQuery(className: "PlaceVO").whereKey("inTrip", equalTo: tripPointer)
            query.findObjectsInBackground { (objects, error) in
                if let error = error {
                    callback(nil, error)
                } else if let objects = objects {
                    let places = objects.map { object -> PlaceVO in
                        PlaceVO(
                            id: object.value(forKey: "objectId") as? String,
                            title:  object.value(forKey: "title") as? String,
                            time: object.value(forKey: "time") as? Int,
                            day: object.value(forKey: "day") as? Int,
                            description: object.value(forKey: "description") as? String,
                            coords: object.value(forKey: "coords") as? CoordsVO,
                            placeImage: URL(string:object.value(forKey: "placeImage") as! String))
                    }
                    callback(places, nil)
                }
            }
        }
    }
    
    func usersForTripRequest(trip: TripVO, callback: @escaping (_ places: [UserVO]?, _ error: Error?) -> ()) {
        if let tripId = trip.id {
            let tripObject = PFObject(withoutDataWithClassName: "TripVO", objectId: tripId)
            let relation = tripObject.relation(forKey: "users")
            let query = relation.query()
            query.findObjectsInBackground { (objects, error) in
                if let error = error {
                    callback(nil, error)
                } else if let objects = objects {
                    let users = objects.map { object -> UserVO in
                        UserVO(id: object.value(forKey: "objectId") as? String,
                               firstName: object.value(forKey: "firstName") as? String,
                               secondName: object.value(forKey: "secondName") as? String,
                               description: object.value(forKey: "description") as? String)
                    }
                    callback(users, nil)
                }
            }
        }
        
    }

}
