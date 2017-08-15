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
                        tripImage:        URL(string:((object.value(forKey: "imageTrip") as! String))),
                        imageBackground:  object.value(forKey: "backgroundTrip") as? [Int],
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
                        tripImage:        URL(string:((object.value(forKey: "imageTrip") as! String))),
                        imageBackground:  object.value(forKey: "backgroundTrip") as? [Int],
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
                            id:            object.value(forKey: "objectId") as? String,
                            title:         object.value(forKey: "title") as? String,
                            time:          object.value(forKey: "Time") as? Int,
                            day:           object.value(forKey: "day") as? Int,
                            details:   object.value(forKey: "details") as? String,
                            coords:        object.value(forKey: "coords") as? PFGeoPoint,
                            placeImage: URL(string:((object.value(forKey: "place_image_url") as! String)))
                        )}
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
                        UserVO(
                            id:             object.value(forKey: "objectId") as? String,
                            firstName:      object.value(forKey: "firstName") as? String,
                            secondName:     object.value(forKey: "secondName") as? String,
                            facebook:       URL(string:((object.value(forKey: "facebook") as! String))),
                            telNumber:      object.value(forKey: "telNumber") as? String,
                            description:    object.value(forKey: "description") as? String,
                            avatar:         object.value(forKey: "avatar") as? PFFile,
                            activationCode: nil)
                    }
                    callback(users, nil)
                }
            }
        }
        
    }
    
    func userTripsRequest(user: UserVO, callback: @escaping (_ places: [TripVO]?, _ error: Error?) -> ()) {
        if let userId = user.id {
            let userObject = PFObject(withoutDataWithClassName: "User", objectId: userId)
            let query = PFQuery(className: "TripVO").whereKey("usersOnTrip", equalTo: userObject)
            query.findObjectsInBackground { (objects, error) in
                if let error = error {
                    callback(nil, error)
                    print(error)
                } else if let objects = objects {
                    let trips = objects.map { object -> TripVO in
                        TripVO(
                            id:               object.value(forKey: "objectId") as? String,
                            title:            object.value(forKey: "title") as? String,
                            fullTitle:        object.value(forKey: "fullTitle") as? String,
                            tripDate:         object.value(forKey: "date") as? Date,
                            tripImage:        URL(string:((object.value(forKey: "imageTrip") as! String))),
                            imageBackground:  object.value(forKey: "backgroundTrip") as? [Int],
                            tripFeatures:     object.value(forKey: "listFeaturesTrip") as? [String],
                            duration:         object.value(forKey: "duration")  as? Int,
                            places:           object.value(forKey: "places")  as? [PlaceVO])
                    }
                    callback(trips, nil)
                }
                
            }
        } else {
            print("Error! User id = nil")
        }
        
    }
    
    func userDataRequest(user: UserVO, callback: @escaping (_ user: UserVO?, _ error: Error?) -> ()) {
        if let userId = user.id {
            let query = PFQuery(className: "_User")
            query.getObjectInBackground(withId: userId) { (object, error) in
                if let error = error {
                    callback(nil, error)
                } else {
                    let user = object.map { object -> UserVO in
                        UserVO(
                            id:             object.value(forKey: "objectId") as? String,
                            firstName:      object.value(forKey: "firstName") as? String,
                            secondName:     object.value(forKey: "secondName") as? String,
                            facebook:       URL(string:((object.value(forKey: "facebook") as! String))),
                            telNumber:      object.value(forKey: "telNumber") as? String,
                            description:    object.value(forKey: "description") as? String,
                            avatar:         object.value(forKey: "avatar") as? PFFile,
                            activationCode:     nil)}
                    callback(user, nil)
                    
                }
                
            }
        } else {
            print("Error! User id = nil")
        }
    }
    
    func updateUserImageRequest(user: UserVO, image: UIImage, callback: @escaping (_ success: Bool, _ error: Error?) ->()) {
        guard let imageData = UIImageJPEGRepresentation(image, 1.0) else {
            print("Image data is nil")
            return
        }
        let imageName = "pic\(user.id!).jpg"
        print(imageName)
        let imageFile = PFFile(name: imageName, data: imageData)
        if let picture = imageFile {
            picture.saveInBackground(block: { (true, false) in
            })
            let currentUser = PFObject(withoutDataWithClassName: "User", objectId: user.id)
            currentUser.setObject(picture, forKey: "avatar")
            currentUser.saveInBackground(block: { (success, error) in
                if success {
                    print("Image is saved")
                    callback(true, nil)
                }
                if error != nil {
                    print("Error occured while uploading a photo")
                    callback(false, error)
                }
                
            })
        }
    }
    
    func userLoginRequest(user: UserVO, callback: @escaping (_ success: Bool, _ error: Error?) ->()) {
        if let code = user.activationCode, let pass = user.activationCode {
            PFUser.logInWithUsername(inBackground: code, password: pass) { (loggedUser, error) in
                if error == nil {
                    print("Ready to go")
                }
            }
        }
    }
}
