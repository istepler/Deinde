//
//  ToursViewCintroller.swift
//  DeindeApp
//
//  Created by Andrey Krit on 7/30/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit
import Parse

class TripsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var object: PFObject?
    
    @IBOutlet weak var tripsTableView: UITableView!
    @IBOutlet weak var allTripsButton: UIButton!
    @IBOutlet weak var freeTripsButton: UIButton!
    
    enum TripsViewControllerState {
        case allTrips(trips: [TripVO]?)
        case freeTrips(trips: [TripVO]?)
    }
    
    let model = TripsModel()
    let userModel = UserModel()
    
    var state: TripsViewControllerState? {
        didSet {
            if let state = state {
                switch state {
                case .allTrips:
                    allTripsButton.backgroundColor = UIColor(colorLiteralRed: 233/255, green: 46/255, blue: 37/255, alpha: 1)
                    freeTripsButton.backgroundColor = UIColor.clear
                case .freeTrips:
                    freeTripsButton.backgroundColor = UIColor(colorLiteralRed: 233/255, green: 46/255, blue: 37/255, alpha: 1)
                    allTripsButton.backgroundColor = UIColor.clear
                }
            }
            tripsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tripsTableView.dataSource = self
        tripsTableView.delegate = self
        state = .allTrips(trips: nil)
        
       // UserModel.instance.currentUser = UserVO(id: "HSNBRRV2pO", firstName: nil, secondName: nil, facebook: nil, telNumber: nil, description: nil, avatar: nil)
        
        
        UserModel.instance.loadUserTrips { (trips, error) in
            print(UserModel.instance.userTrips)
        }
        
      
        
        model.loadAllTrips { [weak self]( trips, error) in
            if let error = error {
                self?.showError()
            } else {
                if let trips = trips {
                    print("GOOD")
                }
            }
        }
        
        model.loadFreeTrips { [weak self]( trips, error) in
            if let error = error {
                self?.showError()
            } else {
                if let trips = trips {
                    for trip in trips {
                        print("-----")
                        print(trip)
                    }
                }
            }
        }
        
        
        // MARK: HARDCODE FOR TESTING
        
//        let  trip = TripVO(id: "RL4t8WTnGL", title: nil, fullTitle: nil, tripDate: nil, tripImage: nil, imageBackground: nil, tripFeatures: nil, duration: nil, places: nil)
//        
//        model.loadPlacesForTrip(trip: trip) { (result, error) in
//            print("--------")
//            for r in result! {
//                print(r.details)
//            }
//        }
//        
//        let dataLoader = DataLoader()
//        dataLoader.userLoginRequest(user: UserModel.instance.currentUser!) { (user, error ) in
//            print("-------")
//            print(user)
//        }
//        
//        
//        let image = UIImage(named: "deinde_logo")!
//        dataLoader.updateUserImageRequest(user: UserModel.instance.currentUser!, image: image) { (success, error) in
//            if success {
//                print("OH yeah")
//            } else if let error = error {
//                print("OH NO")
//            }
//        }
        
        
    

}
    func showError() {
        print("Error while loading data")
    }
    
    
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Actions
    
    @IBAction func allTripsButtonPressed(_ sender: UIButton) {
        state = .allTrips(trips: nil)
    }
    @IBAction func freeTripsButtonPressed(_ sender: UIButton) {
        state = .freeTrips(trips: nil)
    }
    
    // MARK: - TableViewDataSource & TableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tripsTableView.dequeueReusableCell(withIdentifier: "TripTableViewCell") as! TripTableViewCell
        cell.configureCell()
        return cell
    }
    
    
    
    
}
