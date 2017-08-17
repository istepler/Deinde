//
//  TimeThumbView.swift
//  DeindeApp
//
//  Created by Juliya on 16.08.17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit

class TimeThumbView: UIView {
    
    var highlighted: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBOutlet weak var timeLabel: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
