//
//  UserModel.swift
//  DeindeApp
//
//  Created by Andrey Krit on 8/10/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import Foundation

class UserModel {
    
    static var instance = UserModel()
    
    var currentUser: UserVO?
    
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
    
    
    
    
    
    
}
