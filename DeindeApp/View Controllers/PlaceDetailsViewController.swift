//
//  PlaceDetailsViewController.swift
//  DeindeApp
//
//  Created by Juliya on 22.07.17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit

class PlaceDetailsViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MyTourViewController") as! MyTourViewController
        self.present(nextViewController, animated:true, completion:nil)

    }
     override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    //pegevcn

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
