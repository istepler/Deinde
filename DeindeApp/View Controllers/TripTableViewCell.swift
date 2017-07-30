//
//  TripTableViewCell.swift
//  DeindeApp
//
//  Created by Andrey Krit on 7/30/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit

class TripTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tripImageView: UIImageView!
    
    @IBOutlet weak var tripTitleLabel: UILabel!
    
    @IBOutlet weak var dataTitleLabel: UILabel!
    
    @IBOutlet weak var benefitsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    //
    //        // Configure the view for the selected state
    //    }
    
    func configureCell() {
        // TODO: - Configure the cell
        
    }
    
    
    
    
}
