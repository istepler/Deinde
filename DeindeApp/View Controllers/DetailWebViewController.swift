//
//  DetailWebViewController.swift
//  DeindeApp
//
//  Created by Andrey Krit on 7/31/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit

class DetailWebViewController: UIViewController {
    
    @IBOutlet weak var tripDetailsWebView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://deinde.com.ua/tours/suntrip_camp/") 
        tripDetailsWebView.loadRequest(URLRequest(url: url!))

            }

  
}
