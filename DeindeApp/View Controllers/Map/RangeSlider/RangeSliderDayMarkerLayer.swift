//
//  RangeSliderDayMarkerLayer.swift
//  DeindeApp
//
//  Created by Juliya on 27.07.17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit
import QuartzCore

class RangeSliderDayMarkerLayer: CALayer {
    weak var rangeSlider: RangeSlider?
   
    var markerColor: CGColor
    
    init(color: CGColor) {
        self.markerColor = color
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.markerColor = UIColor.white.cgColor
        super.init(coder: aDecoder)
    }
    
    override func draw(in ctx: CGContext) {
        if let slider = rangeSlider {
            let markerFrame = bounds.insetBy(dx: 2.0, dy: 2.0)
            let cornerRadius = markerFrame.height * slider.curvaceousness / 2.0
            let thumbPath = UIBezierPath(roundedRect: markerFrame, cornerRadius: cornerRadius)
            
            ctx.setFillColor(markerColor)
            ctx.addPath(thumbPath.cgPath)
            ctx.fillPath()
            
        }
    }
    

}
