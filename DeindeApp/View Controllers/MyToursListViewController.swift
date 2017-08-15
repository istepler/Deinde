//
//  MyToursListViewController.swift
//  DeindeApp
//
//  Created by Juliya on 10.08.17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit
import SDWebImage

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
        //navigationController?.isNavigationBarHidden = true
        
        
        UserModel.instance.currentUser = UserVO(id: "HSNBRRV2pO", firstName: nil, secondName: nil, facebook: nil, telNumber: nil, description: nil, avatar: nil)
        
        
     UserModel.instance.loadUserTrips { [weak self] ( trips, error) in
            if let error = error {
                self?.showError()
            } else {
                if let trips = trips {
                    for trip in trips {
                        self?.userTrips?.append(trip)
                        //print(trip)
                        
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
        var benefitsStr: String = ""
        
        cell.tripTitleLabel.text = trip?.title
        
        for feature in (trip?.tripFeatures)! {
            if (trip?.tripFeatures?.index(of: feature))! == (trip?.tripFeatures?.count)! - 1 {
            benefitsStr += feature
            } else {
                benefitsStr += feature + "  ●  "
            }
        }
        
        cell.benefitsLabel.text = benefitsStr
        
        //cell.cellBackgroundView.backgroundColor = UIColor.blue
        cell.tripImageView.sd_setImage(with: trip?.tripImage)
        
        
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



