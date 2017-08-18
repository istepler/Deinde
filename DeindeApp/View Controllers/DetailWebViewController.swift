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
    
    var url: URL? 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = url {
        tripDetailsWebView.loadRequest(URLRequest(url: url))
        } else {
            print("URL is disabled")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tripDetailsWebView.stopLoading()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

  
}
