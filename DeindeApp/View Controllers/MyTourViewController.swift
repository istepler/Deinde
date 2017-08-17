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
import CoreLocation
import Parse



class MyTourViewController: UIViewController, GMSMapViewDelegate, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var cotravellersButton: UIButton!
    @IBOutlet weak var viewWithMap: GMSMapView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cotravellersTableView: UITableView!
    @IBOutlet weak var infoWebView: UIWebView!
    @IBOutlet weak var tripNameLabel: UILabel!
    
    var trip = TripVO()
    var tripPlaces: [PlaceVO]? = []
    var tripDays = 0
    var rangeSlider: RangeSlider? = nil
    var markerArray = [MapMarker]()
    var passingPlace = PlaceVO()
    var usersCotravelling: [UserVO] = []{
        didSet {
            cotravellersTableView.reloadData()
        }
    }
    
    
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
        
        if Reachability.isConnectedToNetwork() == true {
            TripsModel.instance.loadPlacesForTrip(trip: trip, callback:  { [weak self] ( places, error) in
                if let error = error {
                    self?.showError()
                } else {
                    if let places = places {
                        for place in places {
                            self?.trip.setPlaces(places: places)
                            self?.tripPlaces?.append(place)
                            
                            
                            self?.setMarkers(coordinates: place.coords!, time: place.time!, totalTime: place.totalHoursNumber!)
                            
                            var sortedPlaces: [PlaceVO] = []
                            let range = Int((self?.rangeSlider?.lowerValue)!)...Int((self?.rangeSlider?.upperValue)!)
                            sortedPlaces = (self?.tripPlaces?.filter { range ~= $0.totalHoursNumber! })!
                            
                            self?.hideAllMarkers()
                            
                            for place in sortedPlaces {
                                let markers = self?.markerArray.filter { $0.totalTime == place.totalHoursNumber
                                }
                                for marker in markers! {
                                    marker.showMarker(map: (self?.viewWithMap)!)
                                }
                            }
                        }
                        self?.tripPlaces = self?.tripPlaces?.sorted(by: { $0.totalHoursNumber! < $1.totalHoursNumber!})
                        self?.setCamera(position: (self?.tripPlaces?[0].coords?.location().coordinate)!)
                    }
                }
                SwiftSpinner.hide()
            })
            
            UserModel.instance.loadUsersForTrip(trip: trip, callback: { [weak self] (users, error) in
                if let error = error {
                    self?.showError()
                } else {
                    if let users = users {
                        for user in users {
                            //print(user)
                            self?.usersCotravelling.append(user)
                        }
                    }
                }
                SwiftSpinner.hide()
            })
            
                    
            tripNameLabel.text = trip.title
            state = .map
            cotravellersTableView.dataSource = self
            cotravellersTableView.delegate = self
            
            //temp url for infowebview
            let url = URL(string: "http://deinde.com.ua/tours/suntrip_camp/")
            infoWebView.loadRequest(URLRequest(url: url!))
            
            //range slider frame values
            let margin: CGFloat = 10.0
            let width: CGFloat = 30.0 
            let height: CGFloat = 200
            
            rangeSlider = RangeSlider(frame:  CGRect(x: margin, y: margin, width: width, height: height * CGFloat(tripDays ) + margin), tripDays: tripDays)
            scrollView.addSubview(rangeSlider!)
            scrollView.contentSize = (rangeSlider?.layer.frame.size)!
            
            rangeSlider?.addTarget(self, action: #selector(MyTourViewController.rangeSliderValueChanged(rangeSlider:)), for: .valueChanged)
            
            viewWithMap?.delegate = self
            
        } else {
            AlertDialog.showAlert("Error", message: "Check your internet connection", viewController: self)
        }
    }

    func setMarkers(coordinates: PFGeoPoint, time: Int, totalTime: Int) {
        let marker = MapMarker(position: CLLocationCoordinate2D(latitude: coordinates.location().coordinate.latitude, longitude: coordinates.location().coordinate.longitude ) , time: String(time), map: viewWithMap, totalTimeOfPlace: totalTime)
        markerArray.append(marker)
    
    }
    
    func setCamera(position: CLLocationCoordinate2D) {
        let camera = GMSCameraPosition.camera(withLatitude: position.latitude, longitude: position.longitude, zoom: 15)
        self.viewWithMap.camera = camera

    }
    
    
    //passing place and performing segue to placedetailsVC
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
       
        for markers in markerArray {
            if marker == markers.marker {
                for place in tripPlaces! {
                    if markers.totalTime == place.totalHoursNumber {
                        passingPlace = place
                       
                    }
                }
            }
        }
        performSegue(withIdentifier: "markerToMyTourDetailsVCSegue", sender: marker)

        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! PlaceDetailsViewController
        destination.place = passingPlace
        destination.tripName = trip.title!
    }
    
    
    override func viewDidLayoutSubviews() {
        let margin: CGFloat = 10.0
        let width: CGFloat = 30.0
        let height: CGFloat = 200
        rangeSlider?.frame = CGRect(x: margin, y: margin, width: width, height: height * CGFloat(tripDays) )
    }

    func rangeSliderValueChanged(rangeSlider: RangeSlider) {
        print("Range slider value changed: \(rangeSlider.lowerValue) \(rangeSlider.upperValue)")
        
        let touch = UITouch()
        let locationY = touch.location(in: scrollView).y
        let lowerLocationY: CGFloat = CGPoint(x: 20, y: scrollView.bounds.height - 50).y
        
        if locationY == lowerLocationY {
             scrollView.contentOffset = CGPoint(x: 0.0, y: scrollView.contentOffset.y + 10.0)
        }
        
        var sortedPlaces: [PlaceVO] = []
        let range = Int(rangeSlider.lowerValue)...Int(rangeSlider.upperValue)
        sortedPlaces = (self.tripPlaces?.filter { range ~= $0.totalHoursNumber! })!
        
        hideAllMarkers()
        
        for place in sortedPlaces {
            let markers = markerArray.filter { $0.totalTime == place.totalHoursNumber }
            
            for marker in markers {
                marker.showMarker(map: viewWithMap)
            }
        }
    }
    
    func hideAllMarkers() {
        for marker in markerArray {
            marker.hideMarker()
        }
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
    
    
    //TableViewDelegate&DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cotravellersTableView.dequeueReusableCell(withIdentifier: "MyTourCotravellersCell") as! MyTourTableViewCell
        let user = usersCotravelling[indexPath.row]
        cell.userNameLabel.text = user.firstName!
        cell.userInfoTextView.text = user.details
        
        if let urlStr = user.avatar?.url {
            let url = URL(string: urlStr)
            cell.userPhotoImageView.sd_setImage(with: url)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersCotravelling.count
    }
    
    func showError() {
        print("Error while loading data")
    }

    
    

}

