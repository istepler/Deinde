//
//  MyTourViewController.swift
//  DeindeApp
//
//  Created by Juliya on 22.07.17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import WARangeSlider



class MyTourViewController: UIViewController, GMSMapViewDelegate  {

   
    var markerArray = [MapMarker]()
    
    @IBOutlet weak var viewWithMap: GMSMapView!
   
    @IBOutlet weak var rangeSliderView: RangeSlider!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sliderController = RangeSliderController(slider: rangeSliderView)
        
        //temp struct fill
        var eventArray = [TripScheduledEvent]()
        var tripEvent = TripScheduledEvent(time: "10:00", latitude: 50.388573, longitude: 30.364974)
        eventArray.append(tripEvent)
        tripEvent = TripScheduledEvent(time: "12:00", latitude: 50.390755, longitude: 30.368890)
        eventArray.append(tripEvent)
        tripEvent = TripScheduledEvent(time: "14:00", latitude: 50.395082, longitude:  30.370599)
        eventArray.append(tripEvent)
        tripEvent = TripScheduledEvent(time: "16:00", latitude: 50.392259, longitude: 30.373192)
        eventArray.append(tripEvent)
        tripEvent = TripScheduledEvent(time: "18:00", latitude: 50.388422, longitude: 30.370306)
        eventArray.append(tripEvent)

        
        let camera = GMSCameraPosition.camera(withLatitude: eventArray[0].latitude, longitude: eventArray[0].longitude, zoom: 15)
        self.viewWithMap.camera = camera
        
        for i in eventArray {
            let marker = MapMarker(position: CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude), time: i.time, map: viewWithMap!)
            markerArray.append(marker)
            
        }
        
        
      
        
        
        viewWithMap?.delegate = self

        self.navigationController?.isNavigationBarHidden = false
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem

    }
    func rangeSliderValueChanged() {
    
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("yes")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MyTourDetailView") as! PlaceDetailsViewController
        self.present(nextViewController, animated:true, completion:nil)
        for markers in markerArray {
            if marker == markers.marker {
                nextViewController.timeLabel.text = markers.timeGl
            }
        }
        return true
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let backItem = UIBarButtonItem()
//        backItem.title = "Back"
//        navigationItem.backBarButtonItem = backItem
//    }
    


}

