//
//  ProfileViewController.swift
//  DeindeApp
//
//  Created by Vlad Kolomiiets on 8/2/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        descriptionTextView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
        
        
    }
    
    
}
