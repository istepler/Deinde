//
//  TripTableViewCell.swift
//  DeindeApp
//
//  Created by Andrey Krit on 7/30/17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit
import SDWebImage

class TripTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var tripTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var featuresLabel: UILabel!
    @IBOutlet weak var tripBackgroundView: UIView!
    @IBOutlet weak var tripImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
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

extension Date {
    static func stringFrom(date:Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        guard let date = date else {
            return ""
        }
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}

func setBackgroundColor(arrayRGB: [Int]?) -> UIColor { // КОСТЫЛИЩЩЕЕЕЕЕЕЕЕ
     var color = UIColor.blue
    guard let arrayRGB = arrayRGB else {
        return color
    }
    if arrayRGB.count != 3 {
        return color
    } else {
        let red = CGFloat(arrayRGB[0])
        let green = CGFloat(arrayRGB[1])
        let blue = CGFloat(arrayRGB[2])
        color = UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
        return color
    }
}

