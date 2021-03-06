//
//  UserModel.swift
//  DeindeApp
//
//  Created by Andrey Krit on 8/10/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//


import Parse
import UIKit

class UserModel {
    
    static var instance = UserModel()
    
    var currentUser: UserVO?
    var loggedUser: PFUser?
    
    private(set) var userTrips: [TripVO]?
    
    func loadUserTrips(callback: @escaping (_ places: [TripVO]?, _ error: Error?) -> ()){
        let dataLoader = DataLoader()
        //SwiftSpinner.show("loading my trips")
        
        if let user = currentUser {
            dataLoader.userTripsRequest(user: user) {[weak self] (trips, error) in
                if let error = error {
                    AlertDialog.showAlert("Error", message: "Sorry, your trips are not laoded", viewController: MyTourViewController())
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
        //SwiftSpinner.show("loading info for trips")

        dataLoader.usersForTripRequest(trip: trip) { (users, error) in
            if let error = error {
                AlertDialog.showAlert("Error", message: "Sorry, problems with loading users", viewController: MyTourViewController())
                print("Error occured")
                print(error)
                callback(nil, error)
            }
            callback(users, nil)
        }
    }
    
    func login(callback: @escaping (_ user: PFUser?, _ error: Error?) -> ()) {
        let dataloader = DataLoader()
        if let currentUser = currentUser {
            dataloader.userLoginRequest(user: currentUser) { (loggedIn, error) in
                if error != nil {
                    print("Error ocured while login)")
                    callback(nil, error)
                } else {
                    //self.loggedIn = loggedIn
                    callback(loggedIn, nil)
                }
            }
        }
    }
    
    func getUserData(user: UserVO, callback: @escaping (_ users: UserVO?, _ error: Error?) -> ()) {
        let dataLoader = DataLoader()
        dataLoader.userDataRequest(user: user) { (user, error) in
            if let error = error {
                print("Error occured while loading userData")
                callback(nil, error)
            } else {
                self.currentUser = user
                callback(user, nil)
            }
        }
    }
    
    func  updateUserFoto(user: UserVO, image: UIImage, callback: @escaping (_ success: Bool, _ error: Error?) ->()) {
        let dataLoader = DataLoader()
        dataLoader.updateUserImageRequest(user: user, image: image) { (success, error) in
            if success {
                callback(true, nil)
            } else {
                callback(false, error)
//              print(error)
            }
        }
    }
    
}


