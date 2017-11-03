//
//  MyToursListViewController.swift
//  DeindeApp
//
//  Created by Juliya on 10.08.17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit
import SDWebImage
import Parse
import SystemConfiguration

class MyToursListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myToursTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var refreshControl = UIRefreshControl()
    
    var userTrips : [TripVO]? = [] {
        didSet {
            myToursTableView.dataSource = self
            myToursTableView.delegate = self
            myToursTableView.reloadData()
            if !(userTrips?.isEmpty)! {
                
                print("trips setted")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if PFUser.current() == nil {

            StID.instance.strId = "MyToursListViewController"
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ActivationViewController") as! ActivationViewController
            navigationController?.setViewControllers([vc], animated: true)
            
        }
       
//        myToursTableView.dataSource = self
//        myToursTableView.delegate = self
        UserModel.instance.currentUser = UserVO(id: "HSNBRRV2pO", firstName: nil, secondName: nil, email: nil, facebook: nil, telNumber: nil, details: nil, avatar: nil, password: nil)//temp user authorization
            if Reachability.isConnectedToNetwork() == true {
            UserModel.instance.loadUserTrips { [weak self] ( trips, error) in
                if let error = error {
                    self?.showError(error: error)
                } else {
                    if let trips = trips {
                        for trip in trips {
                            self?.userTrips?.append(trip)
                        }
                    }
                }
            }
            } else {
                AlertDialog.showAlert("Помилка", message: "Перевірте підключення до інтернету", viewController: self)

        
        if PFUser.current() != nil {
            UserModel.instance.currentUser = UserVO()
            UserModel.instance.currentUser?.id = PFUser.current()?.objectId
        }
                
        refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        if (userTrips?.isEmpty)! {
            loadUserTrips()
        }
                
        myToursTableView.refreshControl = refreshControl
    }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func loadUserTrips() {
        activityIndicator.startAnimating()
        UserModel.instance.loadUserTrips { [weak self] ( trips, error) in
            if let error = error {
                self?.showError(error: error)
            } else {
                if trips != nil {
                    self?.userTrips = UserModel.instance.userTrips
                    self?.endAnimation()
                }
            }
        }
    }
    private func endAnimation() {
        refreshControl.endRefreshing()
        activityIndicator.stopAnimating()
    }
    
    func refreshData() {
       
        loadUserTrips()
    }
    // MARK: - TableViewDataSource & TableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numberOfRows = userTrips?.count {
            return numberOfRows
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myToursTableView.dequeueReusableCell(withIdentifier: "MyToursListTableViewCell") as! MyToursListTableViewCell
        if let trip = userTrips?[indexPath.row] {
            cell.configureCell(trip: trip)
        }
        return cell
    }
    
    func showError(error: Error) {
        AlertDialog.showAlert("Неочiкувана помилка", message: "Спробуйте ще раз", viewController: self)
        print("Error while loading data \(error)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! MyToursListTableViewCell
        let indexPath = myToursTableView.indexPath(for: cell)
        let index = indexPath!.row
        
        if let trip = userTrips?[index] {
        let destination = segue.destination as! MyTourViewController
        destination.trip = trip
            if let duration = trip.duration {
                destination.tripDays = duration
            }
        }
    }

}



