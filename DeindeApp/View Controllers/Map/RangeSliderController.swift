//
//  RangeSliderScrollView.swift
//  DeindeApp
//
//  Created by Juliya on 25.07.17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit
import WARangeSlider

class RangeSliderController {
    
    let rangeSlider: RangeSlider
    
    init (slider: RangeSlider) {
        rangeSlider = slider
        rangeSlider.removeConstraints(self.rangeSlider.constraints)
        rangeSlider.translatesAutoresizingMaskIntoConstraints = true
        
        rangeSlider.transform = rangeSlider.transform.rotated(by: CGFloat((270.0)/180*Double.pi))
    }
    
    

}
