//
//  ViewController.swift
//  DeindeApp
//
//  Created by Andrey Krit on 7/21/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit
import Parse



class ViewController: UIViewController {
    
    let model = UserModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // test Parse from tuturial
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackground { (success: Bool, error: Error?) -> Void in
            print("Object has been saved.")
        }
        
    }
    
}

