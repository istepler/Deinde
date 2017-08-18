//
//  Alert Message.swift
//  moviesTestProgect
//
//  Created by Pavlo Kharambura on 8/2/17.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import Foundation
import UIKit

class AlertDialog {
    
    class func showAlert(_ title: String, message: String, viewController: UIViewController) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(dismissAction)
        
        viewController.present(alertController, animated: true, completion: nil)
        
    }
    
}
