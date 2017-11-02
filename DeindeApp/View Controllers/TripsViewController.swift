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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var refreshControl = UIRefreshControl()
    
    enum TripsViewControllerState {
        case allTrips
    }
    
    var allTrips: [TripVO] = [] {
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
                    
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Reachability.isConnectedToNetwork() == true {
            loadAllTrips()
        } else {
             AlertDialog.showAlert("Помилка", message: "Не вдається підключитись до сервера, спробуйте знову", viewController: self)
        }
        refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        state = .allTrips
        tripsTableView.refreshControl = refreshControl
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    private func endAnimation() {
        refreshControl.endRefreshing()
        activityIndicator.stopAnimating()
    }
    
    
    
    func showError(error: Error) {
        AlertDialog.showAlert("Помилка", message: "Не вдається підключитись до сервера, спробуйте знову", viewController: self)
        print("Error while loading data \(error)")
    }
    
    func loadAllTrips() {
        activityIndicator.startAnimating()
        TripsModel.instance.loadAllTrips { [weak self] (_, error) in
            if let error = error {
                self?.showError(error: error)
            } else {
                self?.allTrips = TripsModel.instance.allTrips
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
    }
    
    // MARK: Actions
    
    @IBAction func allTripsButtonPressed(_ sender: UIButton) {
        state = .allTrips
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
        
        return numberOfRows
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tripsTableView.dequeueReusableCell(withIdentifier: "TripTableViewCell") as! TripTableViewCell
        var trip = TripVO()
        if state == .allTrips {
            trip = allTrips[indexPath.row]
        }
        
        cell.configureCell(trip: trip)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tripsTableView.cellForRow(at: indexPath) as! TripTableViewCell
        let indexPath = tripsTableView.indexPath(for: cell)
        let index = indexPath!.row
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
        if state == .allTrips {
            performSegue(withIdentifier: "detailTripSegue", sender: cell)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! TripTableViewCell
        let indexPath = tripsTableView.indexPath(for: cell)!
        
        if state == .allTrips {
            let destinationVC = segue.destination as! DetailWebViewController
            
            let trip = allTrips[indexPath.row]
            destinationVC.tripTitle = trip.title
            destinationVC.url = trip.detailsUrl
        }
    }
    
}
