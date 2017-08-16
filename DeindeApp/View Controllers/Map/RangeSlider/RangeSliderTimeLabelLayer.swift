//
//  RangeSliderTimeLabelLayer.swift
//  DeindeApp
//
//  Created by Juliya on 15.08.17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import UIKit

class RangeSliderTimeLabelLayer: CALayer {
    
    var highlighted: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    weak var rangeSlider: RangeSlider?
    
    
//    override func draw(in ctx: CGContext) {
//        if let slider = rangeSlider {
//            let thumbFrame = bounds.insetBy(dx: 2.0, dy: 2.0)
//            let cornerRadius = thumbFrame.height * slider.curvaceousness / 2.0
//            let thumbPath = UIBezierPath(roundedRect: thumbFrame, cornerRadius: cornerRadius)
//            
//            ctx.setFillColor(slider.thumbTintColor.cgColor)
//            ctx.addPath(thumbPath.cgPath)
//            ctx.fillPath()
//            
//            
//        }
//    }
//    
//

}
