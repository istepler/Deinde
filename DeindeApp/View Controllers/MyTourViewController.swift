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



class MyTourViewController: UIViewController, GMSMapViewDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate  {
    
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var cotravellersButton: UIButton!
    @IBOutlet weak var viewWithMap: GMSMapView!
    @IBOutlet weak var rangeSliderView: UIView!
    
    @IBOutlet weak var cotravellersTableView: UITableView!
    @IBOutlet weak var infoWebView: UIWebView!
    @IBOutlet weak var tripNameLabel: UILabel!
    
    var trip = TripVO()
    var tripPlaces: [PlaceVO]? = []
    var tripDays = 0
    var rangeSlider: RangeSlider? = nil
    var markerArray = [MapMarker]()
    var passingPlace = PlaceVO()
    var sortedPlaces: [PlaceVO] = []
    var locationManager = CLLocationManager()
    var refreshControl = UIRefreshControl()
    var usersCotravelling: [UserVO] = []{
        didSet {
            cotravellersTableView.reloadData()
        }
    }
    
    var buttonHidden = false
    
    
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
                        rangeSliderView.isHidden = false
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
        
        refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
       
        cotravellersTableView.refreshControl = refreshControl

        if (tripPlaces?.isEmpty)! {
            loadPlacesForTrip()
        }
        if usersCotravelling.isEmpty {
            loadUsersForTrip()
        }
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
            let height: CGFloat = rangeSliderView.bounds.height - 2.0*margin
            
            rangeSlider = RangeSlider(frame:  CGRect(x: margin, y: margin, width: width, height: height  + margin), tripDays: tripDays)
            rangeSliderView.addSubview(rangeSlider!)
            
            rangeSlider?.addTarget(self, action: #selector(MyTourViewController.rangeSliderValueChanged(rangeSlider:)), for: .valueChanged)
            
            viewWithMap.settings.compassButton = true
            viewWithMap.isMyLocationEnabled = true
            viewWithMap.settings.myLocationButton = true
            self.locationManager.delegate = self
            self.locationManager.startUpdatingLocation()

            viewWithMap?.delegate = self
            
        } else {
            AlertDialog.showAlert("Помилка", message: "Перевірте підключення до інтернету", viewController: self)
        }

        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        buttonHidden = false
        cotravellersButton.isHidden = buttonHidden
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
        if segue.identifier == "markerToMyTourDetailsVCSegue" {
            let destination = segue.destination as! PlaceDetailsViewController
            destination.place = passingPlace
            destination.tripName = trip.title!
        }
        if segue.identifier == "detailUserInfo" {
            if let indexPath = cotravellersTableView.indexPathForSelectedRow {
                let destination = segue.destination as! MyTourCotravellersViewController
                let userSegue = usersCotravelling[indexPath.row]
                if userSegue.firstName != nil {
                    destination.userNameVar = userSegue.firstName!
                }
                if userSegue.details != nil {
                    destination.userAboutVar = userSegue.details!
                }
                if userSegue.avatar?.url != nil {
                    destination.userFotoVar = (userSegue.avatar?.url)!
                }
                if userSegue.facebook != nil {
                    destination.userLinkFacebookVar = userSegue.facebook!
                }
                if userSegue.telNumber != nil {
                    destination.userPhoneNumberVar = userSegue.telNumber!
                }
                
            }
            
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        let margin: CGFloat = 10.0
        let width: CGFloat = 30.0
        let height: CGFloat = rangeSliderView.bounds.height - 2.0*margin
        rangeSlider?.frame = CGRect(x: margin, y: 0.0, width: width, height: height  )
    }

    func rangeSliderValueChanged(rangeSlider: RangeSlider) {
        print("Range slider value changed: \(rangeSlider.lowerValue) \(rangeSlider.upperValue)")
      
        
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
        rangeSliderView.isHidden = false
        viewWithMap.isHidden = false
        infoWebView.isHidden = true
        infoWebView.stopLoading()
    }
    
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        state = .info
        infoWebView.isHidden = false
    }
    
    @IBAction func cotravellersButtonPressed(_ sender: UIButton) {
        state = .cotravellers
        cotravellersTableView.isHidden = false
        rangeSliderView.isHidden = true
        viewWithMap.isHidden = true
        infoWebView.isHidden = true
        infoWebView.stopLoading()
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
    
    func loadPlacesForTrip() {
        TripsModel.instance.loadPlacesForTrip(trip: trip, callback:  { [weak self] ( places, error) in
            if let error = error {
                self?.showError(error: error)
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
            //SwiftSpinner.hide()
        })
    }
    
    func loadUsersForTrip() {
        UserModel.instance.loadUsersForTrip(trip: trip, callback: { [weak self] (users, error) in
            if let error = error {
                self?.showError(error: error)
            } else {
                if let users = users {
                    for user in users {
                        //print(user)
                        self?.usersCotravelling.append(user)
                    }
                }
            }
            //SwiftSpinner.hide()
        })
    }

    
    private func endAnimation() {
        refreshControl.endRefreshing()
    }
    
    
    
    func showError(error: Error) {
        AlertDialog.showAlert("Неочiкувана помилка", message: "Спробуйте ще раз", viewController: self)
        print("Error while loading data \(error)")
    }

    func refreshData() {
        
    }

    
    

}

