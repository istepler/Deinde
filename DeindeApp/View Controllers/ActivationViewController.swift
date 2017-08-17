//
//  ActivationViewController.swift
//  DeindeApp
//
//  Created by Andrey Krit on 8/17/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit

class ActivationViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstCodePartTextField: UITextField!
    @IBOutlet weak var secondCodePartTextField: UITextField!
    @IBOutlet weak var thirdCodePartTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        firstCodePartTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func textFieldDidChange(_ textField: UITextField) {
        if textField.text?.characters.count == 2 {
            secondCodePartTextField.becomeFirstResponder()
        }
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
