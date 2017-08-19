//
//  ToursViewCintroller.swift
//  DeindeApp
//
//  Created by Andrey Krit on 7/30/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit
import Parse
import SystemConfiguration

class TripsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tripsTableView: UITableView!
    @IBOutlet weak var allTripsButton: UIButton!
    @IBOutlet weak var freeTripsButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var refreshControl = UIRefreshControl()
    
    enum TripsViewControllerState {
        case allTrips
        case freeTrips
    }
    
    var allTrips: [TripVO] = [] {
        didSet {
            tripsTableView.dataSource = self
            tripsTableView.delegate = self
            tripsTableView.reloadData()
        }
    }
    var freeTrips: [TripVO] = [] {
        didSet {
            tripsTableView.dataSource = self
            tripsTableView.delegate = self
            tripsTableView.reloadData()
        }
    }
    
    var state: TripsViewControllerState? {
        didSet {
            if let state = state {
                switch state {
                case .allTrips:
                    if allTrips.isEmpty {
                        loadAllTrips()
                    } else {
                        tripsTableView.reloadData()
                    }
                    allTripsButton.backgroundColor = UIColor(colorLiteralRed: 233/255, green: 46/255, blue: 37/255, alpha: 1)
                    freeTripsButton.backgroundColor = UIColor.clear
                case .freeTrips:
                    if freeTrips.isEmpty {
                        loadFreeTrips()
                    } else {
                        tripsTableView.reloadData()
                    }
                    freeTripsButton.backgroundColor = UIColor(colorLiteralRed: 233/255, green: 46/255, blue: 37/255, alpha: 1)
                    allTripsButton.backgroundColor = UIColor.clear
                    
                    
                }
            }
            //tripsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        //SwiftSpinner.show("loading trips")
        //if Reachability.isConnectedToNetwork() == true {
        state = .allTrips
        tripsTableView.refreshControl = refreshControl
        
        
        
        //state = .allTrips
        //        } else {
        //            AlertDialog.showAlert("Error", message: "Check your internet connection", viewController: self)
        //        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    private func endAnimation() {
        refreshControl.endRefreshing()
        activityIndicator.stopAnimating()
    }
    
    
    
    func showError(error: Error) {
        AlertDialog.showAlert("Неочiкувана помилка", message: "Спробуйте ще раз", viewController: self)
        print("Error while loading data \(error)")
    }
    
    func loadAllTrips() {
        activityIndicator.startAnimating()
        TripsModel.instance.loadAllTrips { [weak self] (_, error) in
            if let error = error {
                self?.showError(error: error)
            } else {
                self?.allTrips = TripsModel.instance.allTrips
                print(self?.allTrips)
                self?.endAnimation()
            }
        }
    }
    
    func loadFreeTrips() {
        activityIndicator.startAnimating()
        TripsModel.instance.loadFreeTrips { [weak self] (_, error) in
            if let error = error {
                self?.showError(error: error)
            } else {
                self?.freeTrips = TripsModel.instance.freeTrips
                print(self?.freeTrips)
                self?.endAnimation()
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func refreshData() {
        if state == .allTrips {
            loadAllTrips()
        }
        if state == .freeTrips {
            loadFreeTrips()
        }
    }
    
    // MARK: Actions
    
    @IBAction func allTripsButtonPressed(_ sender: UIButton) {
        state = .allTrips
    }
    @IBAction func freeTripsButtonPressed(_ sender: UIButton) {
        state = .freeTrips
    }
    
    // MARK: TableViewDataSource & TableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        if state == .allTrips {
            numberOfRows = allTrips.count
        }
        if state == .freeTrips {
            numberOfRows = freeTrips.count
        }
        return numberOfRows
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tripsTableView.dequeueReusableCell(withIdentifier: "TripTableViewCell") as! TripTableViewCell
        var trip = TripVO()
        if state == .allTrips {
            trip = allTrips[indexPath.row]
        }
        if state == .freeTrips {
            trip = freeTrips[indexPath.row]
        }
        cell.configureCell(trip: trip)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tripsTableView.cellForRow(at: indexPath) as! TripTableViewCell
        if state == .allTrips {
            performSegue(withIdentifier: "detailTripSeuge", sender: cell)
        }
        if state == .freeTrips {
            performSegue(withIdentifier: "detailFreeTripSegue", sender: cell)
        }
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! TripTableViewCell
        let indexPath = tripsTableView.indexPath(for: cell)
        let index = indexPath!.row
        if state == .allTrips {
            let destinationVC = segue.destination as! DetailWebViewController
            let detailTripUrl = allTrips[index].detailsUrl
            let tripTitle = allTrips[index].title
            destinationVC.tripTitle = tripTitle
            destinationVC.url = detailTripUrl
        }
        if state == .freeTrips {
            let cell = sender as! TripTableViewCell
            let indexPath = tripsTableView.indexPath(for: cell)
            let trip = freeTrips[indexPath!.row]
            let destinationVC = segue.destination as? MyTourViewController
            if let vc = destinationVC {
            vc.trip = trip
            if let duration = trip.duration {
                vc.tripDays = duration
                vc.cotravellersButton.isHidden = true
                }
            }
            
        }
    }
    
    
}
