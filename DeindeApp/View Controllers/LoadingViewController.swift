//
//  LoadingViewController.swift
//  DeindeApp
//
//  Created by Andrey Krit on 8/5/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    

    let model = TripsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.loadTrips { [weak self] in
            self?.moveToMainView()
            print(self?.model.allTrips)
            print("--------")
        }
        

        

    }

  
    func moveToMainView() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
        let tripsVC = storyboard.instantiateViewController(withIdentifier: "TripsViewController") as! TripsViewController
        self.navigationController?.setViewControllers([tripsVC], animated: true)
    }
    
}
