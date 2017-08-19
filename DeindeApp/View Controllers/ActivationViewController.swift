//
//  ActivationViewController.swift
//  DeindeApp
//
//  Created by Andrey Krit on 8/17/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit
import SystemConfiguration

class ActivationViewController: UIViewController {
    @IBOutlet weak var firstCodePartTextField: UITextField!
    @IBOutlet weak var secondCodePartTextField: UITextField!
    @IBOutlet weak var thirdCodePartTextField: UITextField!
    
    var previousVCIdentifier = ""
    
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
        let currentUser = UserVO()
        if let firstPart = firstCodePartTextField.text, let  secondPart = secondCodePartTextField.text, let thirdPart = thirdCodePartTextField.text {
            activationCode = firstPart + secondPart + thirdPart
        }
        UserModel.instance.currentUser = currentUser
        UserModel.instance.currentUser?.activationCode = activationCode
        UserModel.instance.login { (loggedIn, error) in
            if error != nil {
                self.showError(error: error!)
            } else {
            UserModel.instance.loggedUser = loggedIn
                print(loggedIn)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: self.previousVCIdentifier) as! ProfileViewController
               // self.navigationController?.setViewControllers([vc], animated: true)
                self.navigationController?.present(vc, animated: true, completion: nil)

            
            }
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func showError(error: Error) {
        AlertDialog.showAlert("Неочiкувана помилка", message: "Спробуйте ще раз", viewController: self)
        print("Error while login \(error)")
    }
    
    
}

