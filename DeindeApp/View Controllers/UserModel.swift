//
//  UserModel.swift
//  DeindeApp
//
//  Created by Andrey Krit on 8/10/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import Foundation
import Parse

class UserModel {
    
    static var instance = UserModel()
    
    var currentUser: UserVO?
    var loggedIn: PFUser?
    
    private(set) var userTrips: [TripVO]?
    
    func loadUserTrips(callback: @escaping (_ places: [TripVO]?, _ error: Error?) -> ()){
        let dataLoader = DataLoader()
        if let user = currentUser {
            dataLoader.userTripsRequest(user: user) {[weak self] (trips, error) in
                if let error = error {
                    callback(nil, error)
                } else {
                    self?.userTrips = trips
                    callback(trips, nil)
                }
            }
        } else {
            print("Current user is indefined")
        }
    }
    
    func loadUsersForTrip(trip: TripVO, callback: @escaping (_ users: [UserVO]?, _ error: Error?) -> ()){
        let dataLoader = DataLoader()
        dataLoader.usersForTripRequest(trip: trip) { (users, error) in
            if let error = error {
                print("Error occured")
                print(error)
                callback(nil, error)
            }
            callback(users, nil)
        }
    }
    
    func login(callback: @escaping (_ user: UserVO?, _ error: Error?) -> ()) {
        let dataloader = DataLoader()
        if let currentUser = currentUser {
            dataloader.userLoginRequest(user: currentUser) { (loggedIn, error) in
                if error != nil {
                    print("Error ocured while login)")
                    callback(nil, error)
                } else {
                    self.loggedIn = loggedIn
                    callback(nil, nil)
                }
            }
        }
        
    }
    
}
