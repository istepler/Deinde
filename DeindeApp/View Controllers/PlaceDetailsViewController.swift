//
//  PlaceDetailsViewController.swift
//  DeindeApp
//
//  Created by Juliya on 22.07.17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit

class PlaceDetailsViewController: UIViewController {
    
    var place = PlaceVO()
    var tripName: String = ""
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var tripNameLabel: UILabel!
    
    @IBOutlet weak var placeTitleTextView: UITextView!
    
    @IBOutlet weak var placeDescriptionTaxtView: UITextView!
    
    @IBOutlet weak var placeImageView: UIImageView!
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    

     override func viewDidLoad() {
        super.viewDidLoad()
        let timeString = String(describing: place.time!) + ":00"
        timeLabel.text = timeString
        placeTitleTextView.text = place.title
        tripNameLabel.text = tripName
        placeDescriptionTaxtView.text = place.details
        placeImageView.sd_setImage(with: place.placeImage)
    }
}
