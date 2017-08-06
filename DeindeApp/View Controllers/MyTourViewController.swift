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



class MyTourViewController: UIViewController, GMSMapViewDelegate, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var cotravellersButton: UIButton!
    @IBOutlet weak var viewWithMap: GMSMapView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cotravellersTableView: UITableView!
    @IBOutlet weak var infoWebView: UIWebView!
    
    
    
    
    let tripDays = 10//temp
    var rangeSlider: RangeSlider? = nil
    
    var markerArray = [MapMarker]()
    
    enum MuToutViewControllerButtonState {
        case map
        case cotravellers
        case info
    }
    
    var state: MuToutViewControllerButtonState? {
        didSet {
            if let state = state {
                switch state {
                    case .map:
                        mapButton.backgroundColor = UIColor(colorLiteralRed: 233/255, green: 46/255, blue: 37/255, alpha: 1)
                        cotravellersButton.backgroundColor = UIColor.clear
                        infoButton.backgroundColor = UIColor.clear
                        cotravellersTableView.isHidden = true
                        scrollView.isHidden = false
                        viewWithMap.isHidden = false
                        infoWebView.isHidden = true
                    case .cotravellers:
                        cotravellersButton.backgroundColor = UIColor(colorLiteralRed: 233/255, green: 46/255, blue: 37/255, alpha: 1)
                        mapButton.backgroundColor = UIColor.clear
                        infoButton.backgroundColor = UIColor.clear
                    case .info:
                        infoButton.backgroundColor = UIColor(colorLiteralRed: 233/255, green: 46/255, blue: 37/255, alpha: 1)
                        mapButton.backgroundColor = UIColor.clear
                        cotravellersButton.backgroundColor = UIColor.clear
                
                }
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        state = .map
        cotravellersTableView.dataSource = self
        cotravellersTableView.delegate = self
        
        let url = URL(string: "http://deinde.com.ua/tours/suntrip_camp/")
        infoWebView.loadRequest(URLRequest(url: url!))
        

        let margin: CGFloat = 10.0
        let width: CGFloat = 30.0 
        let height: CGFloat = 200
        rangeSlider = RangeSlider(frame:  CGRect(x: margin, y: margin, width: width, height: height * CGFloat(tripDays ) + 4.0*margin), tripDays: tripDays)
        
        scrollView.addSubview(rangeSlider!)
      

        scrollView.contentSize = (rangeSlider?.layer.frame.size)!
        
        
        rangeSlider?.addTarget(self, action: #selector(MyTourViewController.rangeSliderValueChanged(rangeSlider:)), for: .valueChanged)
        
        rangeSlider?.addTarget(self, action: #selector(MyTourViewController.thumbTouchedDown(rangeSlider:)), for: .touchDownRepeat)
        

        
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
    
    
    override func viewDidLayoutSubviews() {
        let margin: CGFloat = 10.0
        let width: CGFloat = 30.0
        let height: CGFloat = 200
        print(scrollView.bounds.height)
        print(view.bounds.height)
        rangeSlider?.frame = CGRect(x: margin, y: margin, width: width, height: height * CGFloat(tripDays) )
    }

    func rangeSliderValueChanged(rangeSlider: RangeSlider) {
        print("Range slider value changed: \(rangeSlider.lowerValue) \(rangeSlider.upperValue)")
        
        
        if rangeSlider.upperValue >= 68.0 && (scrollView.contentOffset.y + scrollView.frame.size.height <= scrollView.contentSize.height ){
            scrollView.contentOffset = CGPoint(x: 0.0, y: scrollView.contentOffset.y + 10.0)
            
           
        }
        
        
    }
    
    func thumbTouchedDown(rangeSlider: RangeSlider) {
        print("touchDown")
        
        
    }
    
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func mapButtonPressed(_ sender: UIButton) {
        state = .map
        cotravellersTableView.isHidden = true
        scrollView.isHidden = false
        viewWithMap.isHidden = false
        infoWebView.isHidden = true
    }
    
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        state = .info
        infoWebView.isHidden = false
    }
    
    @IBAction func cotravellersButtonPressed(_ sender: UIButton) {
        state = .cotravellers
        cotravellersTableView.isHidden = false
        scrollView.isHidden = true
        viewWithMap.isHidden = true
        infoWebView.isHidden = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cotravellersTableView.dequeueReusableCell(withIdentifier: "MyTourCotravellersCell") as! MyTourTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    

}

