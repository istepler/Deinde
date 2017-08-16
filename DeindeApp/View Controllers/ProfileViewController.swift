//
//  ProfileViewController.swift
//  DeindeApp
//
//  Created by Vlad Kolomiiets on 8/2/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var userPhotoImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.descriptionTextView.delegate = self
        self.phoneNumberTextField.delegate = self
        self.nameTextField.delegate = self
        
        descriptionTextView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
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
        userPhotoImage.image = image.circleMasked
        
        picker.dismiss(animated: true, completion: nil)
        
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
    
    @IBAction func facebookloginButton(_ sender: UIButton) {
    }
}
// MARK: - UIImage extension
extension UIImage {
    var isPortrait:  Bool    { return size.height > size.width }
    var isLandscape: Bool    { return size.width > size.height }
    var breadth:     CGFloat { return min(size.width, size.height) }
    var breadthSize: CGSize  { return CGSize(width: breadth, height: breadth) }
    var breadthRect: CGRect  { return CGRect(origin: .zero, size: breadthSize) }
    var circleMasked: UIImage? {
        UIGraphicsBeginImageContextWithOptions(breadthSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let cgImage = cgImage?.cropping(to: CGRect(origin: CGPoint(x: isLandscape ? floor((size.width - size.height) / 2) : 0, y: isPortrait  ? floor((size.height - size.width) / 2) : 0), size: breadthSize)) else { return nil }
        UIBezierPath(ovalIn: breadthRect).addClip()
        UIImage(cgImage: cgImage, scale: 1, orientation: imageOrientation).draw(in: breadthRect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}





