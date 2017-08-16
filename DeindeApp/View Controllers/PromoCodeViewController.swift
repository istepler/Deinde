//
//  PromoCodeViewController.swift
//  DeindeApp
//
//  Created by max36 on 8/16/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit

class CodeViewController: UIViewController {
    
    @IBOutlet weak var promoCode1: UITextField!
    @IBOutlet weak var promoCode2: UITextField!
    @IBOutlet weak var promoCode3: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        promoCode1.delegate = self
        promoCode2.delegate = self
        promoCode3.delegate = self
    }
    
    
    @IBAction func enterTravel(_ sender: Any) {
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        promoCode1.resignFirstResponder()
        promoCode2.resignFirstResponder()
        promoCode3.resignFirstResponder()
    }
}

extension ViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return
    }
}
