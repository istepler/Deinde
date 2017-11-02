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

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var previousVCIdentifier = StID.instance.strId
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if previousVCIdentifier == "MyToursListViewController" {
            tabBarController?.tabBar.items![2].isEnabled = false
        } else if previousVCIdentifier == "ProfileViewController" {
            tabBarController?.tabBar.items![1].isEnabled = false
        }
        
    }

    
    @IBAction func beginTravelButtonPressed(_ sender: Any) {
        var usrPassword = ""
        var email = ""
        let currentUser = UserVO()
        if let passwordPart = passwordTextField.text, let emailPart = emailTextField.text {
            usrPassword = passwordPart
            email = emailPart
        }
        
        UserModel.instance.currentUser = currentUser
        UserModel.instance.currentUser?.password = usrPassword
        UserModel.instance.currentUser?.email = email
     
        UserModel.instance.login { (loggedIn, error) in
            if error != nil {
                if usrPassword == "" || email == "" {
                    AlertDialog.showAlert("Помилка", message: "Ви не ввели всі потрібні поля!", viewController: self)
                }
                self.showError(error: error!)
            } else {
                
            UserModel.instance.loggedUser = loggedIn
                self.navigationController?.popViewController(animated: true)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if self.previousVCIdentifier == "MyToursListViewController" {
                    let vc = storyboard.instantiateViewController(withIdentifier: self.previousVCIdentifier) as! MyToursListViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                    self.tabBarController?.tabBar.items![2].isEnabled = true

                } else if self.previousVCIdentifier == "ProfileViewController" {
                    let vc = storyboard.instantiateViewController(withIdentifier: self.previousVCIdentifier) as! ProfileViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                    self.tabBarController?.tabBar.items![1].isEnabled = true
                }
            }
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    func showError(error: Error) {
    AlertDialog.showAlert("Помилка", message: "Користувача не знайдено, перевірте введені дані!", viewController: self)
        print("Error while login \(error)")
    }

}

