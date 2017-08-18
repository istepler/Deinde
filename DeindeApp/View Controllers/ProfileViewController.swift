//
//  ProfileViewController.swift
//  DeindeApp
//
//  Created by Vlad Kolomiiets on 8/2/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import SwiftyJSON
import Parse

class ProfileViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var userPhotoImage: UIButton!
    @IBOutlet weak var facebookLoginButton: UIButton!
    
    @IBAction func facebookLoginButtonPressed(_ sender: UIButton!) {
        let loginManager = LoginManager()
        if AccessToken.current == nil {
            loginManager.logIn([ .publicProfile ], viewController: self) { loginResult in
                switch loginResult {
                case .failed(let error):
                    print(error)
                case .cancelled:
                    self.viewDidAppear(true)
                case .success( _, _, _):
                    self.facebookLoginButton.alpha = 1.0
                    let fbUserData = GraphRequestConnection()
                    fbUserData.add(GraphRequest(graphPath: "/me", parameters: ["fields": "name, picture.type(large), link"], accessToken: AccessToken.current, httpMethod: GraphRequestHTTPMethod(rawValue: "GET")!, apiVersion: GraphAPIVersion.defaultVersion)) { httpResponse, result in
                        switch result {
                        case .success(let response):
                            self.nameTextField.text? = (response.dictionaryValue?["name"] as? String)!
                            //var link = (response.dictionaryValue?["link"] as? String)!
                            //var pictureFB = JSON(response.dictionaryValue?["picture"] as Any)
                            //var pictureFBData = pictureFB["data"].dictionary
                        //var pictureFBURL = pictureFBData?["url"]?.string
                        case .failed(let error):
                            print("Graph Request Failed: \(error)")
                        }
                    }
                    fbUserData.start()
                }
            }
        } else {
            loginManager.logOut()
            self.viewDidAppear(true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.descriptionTextView.delegate = self
        self.phoneNumberTextField.delegate = self
        self.nameTextField.delegate = self
        
        descriptionTextView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if PFUser.current() == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ActivationViewController") as!ActivationViewController
            navigationController?.pushViewController(vc, animated: false)
        }
        
        if AccessToken.current == nil {
            facebookLoginButton.alpha = 0.5
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.phoneNumberTextField.resignFirstResponder()
        self.nameTextField.resignFirstResponder()
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        userPhotoImage.setImage(image, for: .normal)
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        
        userPhotoImage.layer.cornerRadius = userPhotoImage.frame.size.width/2
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        let newLength = text.utf16.count + string.utf16.count - range.length
        return newLength <= 20 // Bool
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.characters.count
        return numberOfChars < 70
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Actions
    @IBAction func avatarButton(_ sender: UIButton) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                print("Camera not available")
            }
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    //    func maskRoundedImage(image: UIImage, radius: Float) -> UIImage {
    //        var imageView: UIImageView = UIImageView(image: image)
    //        var layer: CALayer = CALayer()
    //        layer = imageView.layer
    //
    //        layer.masksToBounds = true
    //        layer.cornerRadius = CGFloat(radius)
    //
    //        UIGraphicsBeginImageContext(imageView.bounds.size)
    //        layer.render(in: UIGraphicsGetCurrentContext()!)
    //        var roundedImage = UIGraphicsGetImageFromCurrentImageContext()
    //        UIGraphicsEndImageContext()
    //
    //        return roundedImage!
    //    }
    
    @IBAction func editButton(_ sender: UIButton) {
        nameTextField.inputView?.isUserInteractionEnabled = true
        nameTextField.becomeFirstResponder()
    }
    
}

// MARK: - UIImage extension
//extension UIImage {
//    var isPortrait:  Bool    { return size.height > size.width }
//    var isLandscape: Bool    { return size.width > size.height }
//    var breadth:     CGFloat { return min(size.width, size.height) }
//    var breadthSize: CGSize  { return CGSize(width: breadth, height: breadth) }
//    var breadthRect: CGRect  { return CGRect(origin: .zero, size: breadthSize) }
//    var circleMasked: UIImage? {
//        UIGraphicsBeginImageContextWithOptions(breadthSize, false, scale)
//        defer { UIGraphicsEndImageContext() }
//        guard let cgImage = cgImage?.cropping(to: CGRect(origin: CGPoint(x: isLandscape ? floor((size.width - size.height) / 2) : 0, y: isPortrait  ? floor((size.height - size.width) / 2) : 0), size: breadthSize)) else { return nil }
//        UIBezierPath(ovalIn: breadthRect).addClip()
//        UIImage(cgImage: cgImage, scale: 1, orientation: imageOrientation).draw(in: breadthRect)
//        return UIGraphicsGetImageFromCurrentImageContext()
//    }
//}





