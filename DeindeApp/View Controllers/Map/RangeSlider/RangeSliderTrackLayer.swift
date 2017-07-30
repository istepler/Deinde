//
//  RangeSliderTrackLayer.swift
//  RangeSliderExample
//
//  Created by Juliya on 27.07.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import UIKit
import QuartzCore

class RangeSliderTrackLayer: CALayer {
    weak var rangeSlider: RangeSlider?
    
    override func draw(in ctx: CGContext) {
        if let slider = rangeSlider {
            let cornerRadius = bounds.width * slider.curvaceousness / 2.0
            let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            ctx.addPath(path.cgPath)
            
            ctx.setFillColor(slider.trackTintColor.cgColor)
            ctx.addPath(path.cgPath)
            ctx.fillPath()
            
            ctx.setFillColor(slider.trackHighlightTintColor.cgColor)
            let lowerValuePosition = CGFloat(slider.positionForValue(value: slider.lowerValue))
            let upperValuePosition = CGFloat(slider.positionForValue(value: slider.upperValue))
            let rect = CGRect(x: 0.0, y: lowerValuePosition, width: bounds.width, height: upperValuePosition - lowerValuePosition)
            ctx.fill(rect)
            
        }
    }
    
    
}
