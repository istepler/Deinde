//
//  MyTourCotravellersViewController.swift
//  DeindeApp
//
//  Created by klayd23 on 18.08.17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit

class MyTourCotravellersViewController: UIViewController {
    @IBOutlet weak var userFoto: UIImageView!
    var userFotoVar:String?
    
    @IBOutlet weak var userName: UILabel!
    var userNameVar:String = ""
    
    @IBOutlet weak var userAbout: UILabel!
    var userAboutVar:String = ""
    
    @IBOutlet weak var userLinkFacebook: UIButton!
    var userLinkFacebookVar:URL?
    
    @IBOutlet weak var userPhoneNumber: UIButton!
    
    var userPhoneNumberVar:String?
    
    @IBOutlet weak var line1: UIView!
    @IBOutlet weak var line2: UIView!
    @IBAction func closeButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    @IBAction func openLinkFacebook(_ sender: Any) {
        UIApplication.shared.openURL(userLinkFacebookVar!)
    }
    @IBAction func callToUser(_ sender: Any) {
        var getNumber:String = userPhoneNumber.titleLabel?.text ?? ""
        getNumber = getNumber.replacingOccurrences(of: " ", with: "")
        getNumber = getNumber.replacingOccurrences(of: "+", with: "")
        guard let number = URL(string: "telprompt://\(getNumber)") else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(number)
        } else {
            // Fallback on earlier versions
            UIApplication.shared.openURL(number)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.text = userNameVar
        userAbout.text = userAboutVar
        let url = URL(string: userFotoVar!)
        userFoto.sd_setImage(with: url)
        
        if userLinkFacebookVar == nil  {
            userLinkFacebook.alpha = 0.25
        }
        userPhoneNumber.setTitle(userPhoneNumberVar, for: .normal)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
