//
//  MyTourTableViewCell.swift
//  DeindeApp
//
//  Created by Juliya on 06.08.17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit

class MyTourTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var userPhotoImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userInfoTextView: UITextView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
