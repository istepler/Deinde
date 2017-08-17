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

class MyToursListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myToursTableView: UITableView!
    
    var userTrips : [TripVO]? = [] {
        didSet {
            myToursTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myToursTableView.dataSource = self
        myToursTableView.delegate = self
    
        UserModel.instance.currentUser = UserVO(id: "HSNBRRV2pO", firstName: nil, secondName: nil, facebook: nil, telNumber: nil, details: nil, avatar: nil, activationCode: nil)//temp user authorization
        
        UserModel.instance.loadUserTrips { [weak self] ( trips, error) in
            if let error = error {
                self?.showError()
            } else {
                if let trips = trips {
                    for trip in trips {
                        self?.userTrips?.append(trip)
                        print(trip)
                    }
                }
            }
        }
    }

    
    // MARK: - TableViewDataSource & TableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (userTrips?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myToursTableView.dequeueReusableCell(withIdentifier: "MyToursListTableViewCell") as! MyToursListTableViewCell
        let trip = userTrips?[indexPath.row]
        cell.configureCell(trip: trip!)
        
        return cell
    }
    
    func showError() {
        print("Error while loading data")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UITableViewCell
        let indexPath = myToursTableView.indexPath(for: cell)!
        let trip = userTrips?[indexPath.row]
        let destination = segue.destination as! MyTourViewController
        destination.trip = trip!
        destination.tripDays = (trip?.duration)!
        
    }

}



