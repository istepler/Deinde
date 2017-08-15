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
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MyTourViewController") as! MyTourViewController
        self.present(nextViewController, animated:true, completion:nil)

    }
    
    
    
    
    
    
     override func viewDidLoad() {
        super.viewDidLoad()
        let timeString = String(describing: place.time!) + ":00"
        timeLabel.text = timeString
        placeTitleTextView.text = place.title
        tripNameLabel.text = tripName
        placeDescriptionTaxtView.text = place.details
        placeImageView.sd_setImage(with: place.placeImage)
        //navigationController?.isNavigationBarHidden = false
        
        
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //navigationController?.navigationBar.isHidden = true
    }
    //pegevcn

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
