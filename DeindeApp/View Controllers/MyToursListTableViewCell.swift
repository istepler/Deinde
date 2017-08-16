//
//  MyToursListTableViewCell.swift
//  DeindeApp
//
//  Created by Juliya on 10.08.17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit

class MyToursListTableViewCell: UITableViewCell {

   
    @IBOutlet weak var tripBackgroundView: UIView!
    @IBOutlet weak var tripImage: UIImageView!
    @IBOutlet weak var featuresLabel: UILabel!
    @IBOutlet weak var tripTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
   
    
    func configureCell(trip: TripVO) {
        var featuresString = ""
        guard let features = trip.tripFeatures else {
            return
        }
        for feature in features {
            featuresString += feature + "  ● "
        }
        featuresLabel.text = featuresString
        tripTitleLabel.text = trip.fullTitle
        dateLabel.text = Date.stringFrom(date: trip.tripDate)
        tripImage.sd_setImage(with: trip.tripImage)
        tripBackgroundView.backgroundColor = setBackgroundColor(arrayRGB: trip.imageBackground)
    }
    
}

