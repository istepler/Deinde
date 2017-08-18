//
//  ActivationViewController.swift
//  DeindeApp
//
//  Created by Andrey Krit on 8/17/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit

class ActivationViewController: UIViewController {
    @IBOutlet weak var firstCodePartTextField: UITextField!
    @IBOutlet weak var secondCodePartTextField: UITextField!
    @IBOutlet weak var thirdCodePartTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
        
    }
    
    
    func firstPartTextFieldDidChange(_ textField: UITextField) {
        if firstCodePartTextField.text?.characters.count == 2 {
            secondCodePartTextField.becomeFirstResponder()
            if secondCodePartTextField.text?.characters.count == 2 {
                thirdCodePartTextField.becomeFirstResponder()
                if thirdCodePartTextField.text?.characters.count == 2 {
                    self.view.endEditing(true)
                }
            }
        }
    }
    
    func secondPartTextFieldDidChange(_ textField: UITextField) {
        if secondCodePartTextField.text?.characters.count == 2 {
            thirdCodePartTextField.becomeFirstResponder()
            if thirdCodePartTextField.text?.characters.count == 2 {
                self.view.endEditing(true)
            }
        }
    }
    
    func thirdPartTextFieldDidChange(_ textField: UITextField) {
        if thirdCodePartTextField.text?.characters.count == 2 {
            self.view.endEditing(true)
        }
        
    }
    
    func addTargets() {
        firstCodePartTextField.addTarget(self, action: #selector(firstPartTextFieldDidChange(_:)), for: .editingChanged)
        secondCodePartTextField.addTarget(self, action: #selector(secondPartTextFieldDidChange(_:)), for: .editingChanged)
        thirdCodePartTextField.addTarget(self, action: #selector(thirdPartTextFieldDidChange(_:)), for: .editingChanged)

    }
    
    @IBAction func beginTravelButtonPressed(_ sender: Any) {
        var activationCode = ""
        if let firstPart = firstCodePartTextField.text, let  secondPart = secondCodePartTextField.text, let thirdPart = thirdCodePartTextField.text {
            activationCode = firstPart + secondPart + thirdPart
        }
        
        UserModel.instance.currentUser?.activationCode = activationCode
        UserModel.instance.login { (user, error) in
            if error != nil {
                print("Error")
            } else {
            self.navigationController?.popViewController(animated: true)
            print(user)
            }
            
        }
    }
    
    
    
}

