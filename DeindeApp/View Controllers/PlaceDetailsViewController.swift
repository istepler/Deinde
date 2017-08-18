//
//  PlaceDetailsViewController.swift
//  DeindeApp
//
//  Created by Juliya on 22.07.17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit
import CoreLocation

class PlaceDetailsViewController: UIViewController, UINavigationControllerDelegate {
    
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
    
    @IBAction func goToGoogleMapsAppButtonPressed(_ sender: UIButton) {
        
        let placeCoords = CLLocationCoordinate2D(latitude: (place.coords?.latitude)!, longitude: (place.coords?.longitude)!)
        
        let testURL = URL(string: "comgooglemaps-x-callback://")!
        let nextTestURL = URL(string: "https://")!
        if UIApplication.shared.canOpenURL(testURL) {  //goes to google maps фзз
            let directionsRequest = "comgooglemaps-x-callback://" +
                "?daddr=\(placeCoords.latitude),\(placeCoords.longitude)&zoom=14" +
            "&x-success=sourceapp://?resume=true&x-source=AirApp"
            
            let directionsURL = URL(string: directionsRequest)!
            UIApplication.shared.openURL(directionsURL)
        } else if UIApplication.shared.canOpenURL(nextTestURL){ // goes to safari google maps
            let directionsRequest = "https://maps.google.com/maps?f=d&" +
                "daddr=\(placeCoords.latitude),\(placeCoords.longitude)&zoom=14" +
            "&x-success=sourceapp://?resume=true&x-source=AirApp"
            let directionsURL = URL(string: directionsRequest)!
            UIApplication.shared.openURL(directionsURL)

        }

    }

     override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        let timeString = String(describing: place.time!) + ":00"
        timeLabel.text = timeString
        placeTitleTextView.text = place.title
        tripNameLabel.text = tripName
        placeDescriptionTaxtView.text = place.details
        placeImageView.sd_setImage(with: place.placeImage)
    }
    
}
