//
//  MyToursListTableViewCell.swift
//  DeindeApp
//
//  Created by Juliya on 10.08.17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit

class MyToursListTableViewCell: UITableViewCell {

    @IBOutlet weak var tripImageView: UIImageView!
    
    @IBOutlet weak var tripTitleLabel: UILabel!
    
    @IBOutlet weak var benefitsLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var cellBackgroundView: UIView!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
