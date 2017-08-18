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
    
    @IBOutlet weak var tripsTableView: UITableView!
    @IBOutlet weak var allTripsButton: UIButton!
    @IBOutlet weak var freeTripsButton: UIButton!
    
    
    enum TripsViewControllerState {
        case allTrips(trips: [TripVO]?)
        case freeTrips(trips: [TripVO]?)
    }
    
    var trips: [TripVO] = [] {
        didSet {
            tripsTableView.reloadData()
        }
    }
    
    var state: TripsViewControllerState? {
        didSet {
            if let state = state {
                switch state {
                case .allTrips:
                    allTripsButton.backgroundColor = UIColor(colorLiteralRed: 233/255, green: 46/255, blue: 37/255, alpha: 1)
                    freeTripsButton.backgroundColor = UIColor.clear
                    self.trips = TripsModel.instance.allTrips
                case .freeTrips:
                    freeTripsButton.backgroundColor = UIColor(colorLiteralRed: 233/255, green: 46/255, blue: 37/255, alpha: 1)
                    allTripsButton.backgroundColor = UIColor.clear
                    self.trips = TripsModel.instance.freeTrips
                    
                }
            }
            //tripsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllTrips()
        loadFreeTrips()
        tripsTableView.dataSource = self
        tripsTableView.delegate = self
        state = .allTrips(trips: nil)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    
    
    func showError(error: Error) {
        print("Error while loading data \(error)")
    }
    
    func loadAllTrips() {
        TripsModel.instance.loadAllTrips { [weak self] (_, error) in
            if let error = error {
                self?.showError(error: error)
            } else {
                self?.trips = TripsModel.instance.allTrips
                print(self?.trips)
            }
        }
    }
    
    func loadFreeTrips() {
        TripsModel.instance.loadFreeTrips { [weak self] (_, error) in
            if let error = error {
                self?.showError(error: error)
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Actions
    
    @IBAction func allTripsButtonPressed(_ sender: UIButton) {
        state = .allTrips(trips: nil)
    }
    @IBAction func freeTripsButtonPressed(_ sender: UIButton) {
        state = .freeTrips(trips: nil)
    }
    
    // MARK: TableViewDataSource & TableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tripsTableView.dequeueReusableCell(withIdentifier: "TripTableViewCell") as! TripTableViewCell
        let trip = trips[indexPath.row]
        cell.configureCell(trip: trip)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tripsTableView.cellForRow(at: indexPath) as! TripTableViewCell
        performSegue(withIdentifier: "detailTripSeuge", sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! TripTableViewCell
        let indexPath = tripsTableView.indexPath(for: cell)
        let index = indexPath?.row
        let destinationVC = segue.destination as! DetailWebViewController
        let detailTripUrl = trips[index!].detailsUrl
        destinationVC.url = detailTripUrl
    }
}
