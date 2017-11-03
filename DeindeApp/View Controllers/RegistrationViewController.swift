//
//  RegistrationViewController.swift
//  DeindeApp
//
//  Created by Pavlo Kharambura on 11/2/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func registerUser(_ sender: UIButton) {
        
        let dataloader = DataLoader()
        if firstNameTextField.text != "" && lastNameTextField.text != "" && emailTextField.text != "" && passwordTextField.text != "" {
            dataloader.userRegisterRequest(email: emailTextField.text!, password: passwordTextField.text!, firstName: firstNameTextField.text!, secondName: lastNameTextField.text!)
         
            navigationController?.popViewController(animated: true)
            
        } else {
            AlertDialog.showAlert("Помилка", message: "Ви не ввели всі поля!", viewController: self)
        }
        
        
        
    }
    
    
}
