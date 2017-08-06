//
//  ToursViewCintroller.swift
//  DeindeApp
//
//  Created by Andrey Krit on 7/30/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit

class TripsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tripsTableView: UITableView!
    @IBOutlet weak var allTripsButton: UIButton!
    @IBOutlet weak var freeTripsButton: UIButton!
    
    enum TripsViewControllerState {
        case allTrips(trips: [TripVO]?)
        case freeTrips(trips: [TripVO]?)
    }
    
    let model = TripsModel()
    
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
