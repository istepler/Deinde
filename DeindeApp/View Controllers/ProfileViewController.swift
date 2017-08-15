//
//  ProfileViewController.swift
//  DeindeApp
//
//  Created by Vlad Kolomiiets on 8/2/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import SwiftyJSON

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var descriptionTextView: UITextView!
  
    @IBOutlet weak var photoFB: UIImageView!
    @IBOutlet weak var nameFacebook: UILabel!
    @IBOutlet weak var facebookLoginButtom: UIButton!
    
    
    
    @IBAction func loginButtonClicked (_ sender: UIButton!) {
        let loginManager = LoginManager()
        if AccessToken.current == nil {
            loginManager.logIn([ .publicProfile ], viewController: self) { loginResult in
                switch loginResult {
                case .failed(let error):
                    print(error)
                case .cancelled:
                    self.viewDidAppear(true)
                case .success( _, _, _):
                    self.facebookLoginButtom.alpha = 1.0
                    let fbUserData = GraphRequestConnection()
                    fbUserData.add(GraphRequest(graphPath: "/me", parameters: ["fields": "name, picture.type(large), link"], accessToken: AccessToken.current, httpMethod: GraphRequestHTTPMethod(rawValue: "GET")!, apiVersion: GraphAPIVersion.defaultVersion)) { httpResponse, result in
                        switch result {
                        case .success(let response):
                            self.nameFacebook.text? = (response.dictionaryValue?["name"] as? String)!
                            //var link = (response.dictionaryValue?["link"] as? String)!
                            //var pictureFB = JSON(response.dictionaryValue?["picture"] as Any)
                            //var pictureFBData = pictureFB["data"].dictionary
                            //var pictureFBURL = pictureFBData?["url"]?.string
                        case .failed(let error):
                            print("Graph Request Failed: \(error)")
                        }
                    }
                fbUserData.start()
                }
            }
        } else {
            loginManager.logOut()
            self.viewDidAppear(true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        descriptionTextView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
            }
    
    override func viewDidAppear(_ animated: Bool) {
        if AccessToken.current == nil {
            facebookLoginButtom.alpha = 0.25
        }
    }
        
}
