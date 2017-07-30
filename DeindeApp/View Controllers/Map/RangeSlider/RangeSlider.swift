//
//  RangeSlider.swift
//  RangeSliderExample
//
//  Created by Juliya on 27.07.17.
//  Copyright © 2017 Juliya. All rights reserved.
//

import UIKit
import QuartzCore

class RangeSlider: UIControl {

    var minimumValue: Double = 0.0 {
        didSet {
            updateLayerFrames()
        }
    }
    var maximumValue: Double = 24.0 {
        didSet {
            updateLayerFrames()
        }
    }

    var lowerValue = 2.0 {
        didSet {
            updateLayerFrames()
        }
    }

    var upperValue = 16.0 {
        didSet {
            updateLayerFrames()
        }
    }
    var trackTintColor = UIColor(white: 0.9, alpha: 1.0) {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }
    var trackHighlightTintColor = UIColor.red {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }

    var thumbTintColor = UIColor.red {
        didSet {
            lowerThumbLayer.setNeedsDisplay()
            upperThumbLayer.setNeedsDisplay()
        }
    }

    
    var curvaceousness: CGFloat = 1.0 {
        didSet {
            trackLayer.setNeedsDisplay()
            lowerThumbLayer.setNeedsDisplay()
            upperThumbLayer.setNeedsDisplay()
            
        }
    }



    var tripDays: Int = 0
    var dayLabelLayers = [CATextLayer]()
    var dayMarkerLayers = [RangeSliderDayMarkerLayer]()
    let trackLayer = RangeSliderTrackLayer()
    let lowerThumbLayer = RangeSliderThumbLayer()
    let upperThumbLayer = RangeSliderThumbLayer()
    
    var previousLocation = CGPoint()
    
    

    
    var thumbWidth: CGFloat {
        return CGFloat(bounds.width/1.5)
    }
    var markerWidth: CGFloat {
        return CGFloat(bounds.width/2.2)
    }
    
    
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
            
        }
    }

       
    init (frame: CGRect, tripDays: Int)
    {
        self.tripDays = tripDays
        
        super.init(frame: frame)
        
        trackLayer.rangeSlider = self
        trackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(trackLayer)
        
        lowerThumbLayer.rangeSlider = self
        lowerThumbLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(lowerThumbLayer)
        
        upperThumbLayer.rangeSlider = self
        upperThumbLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(upperThumbLayer)
        
        for i in 0...tripDays {
            dayMarkerLayers.append(RangeSliderDayMarkerLayer(color: RangeSliderDayMarkerColors.colorsArray[i]))
            dayLabelLayers.append(CATextLayer())
        }
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setMarkers() {
        //marker created
        if dayMarkerLayers.count == 0 {
            return
        }
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)

        for i in 0...tripDays {
            let dayMarkerLayer = dayMarkerLayers[i]
            dayMarkerLayer.rangeSlider = self
            dayMarkerLayer.contentsScale = UIScreen.main.scale
            layer.addSublayer(dayMarkerLayer)
            
            
            
            let dayMarkerCenter = CGFloat(round(positionForValueOfMarker(value: 0.0 + Double(i) * maximumValue)))
            dayMarkerLayer.frame = CGRect(x: round((bounds.width - markerWidth) / 2), y: round(dayMarkerCenter - markerWidth/2.0), width: round(markerWidth), height: round(markerWidth))
            
            dayMarkerLayer.setNeedsDisplay()
            
            let dayLabelLayer = dayLabelLayers[i]
            dayLabelLayer.font = UIFont(name: "Arial", size: 16)
            dayLabelLayer.fontSize = 16
            dayLabelLayer.frame = CGRect(x: round(bounds.width - 2 * thumbWidth), y: round(dayMarkerCenter - markerWidth/1.5) , width: round(thumbWidth), height: round(thumbWidth))
            dayLabelLayer.string = String(i+1)
            dayLabelLayer.foregroundColor = RangeSliderDayMarkerColors.colorsArray[i]
            dayLabelLayer.alignmentMode = "center"
            
            layer.addSublayer(dayLabelLayer)
            
        }
        
        CATransaction.commit()

    
    }
    
    var ifSet = false
    
    func updateLayerFrames() {
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        
        
        trackLayer.frame = bounds.insetBy(dx: bounds.width / 2.2, dy: 0.0)
        trackLayer.setNeedsDisplay()
        
        let lowerThumbCenter = CGFloat(positionForValue(value: lowerValue))
        
        lowerThumbLayer.frame = CGRect(x: (bounds.width - thumbWidth) / 2, y: lowerThumbCenter - thumbWidth / 2.0, width: thumbWidth, height: thumbWidth)
        lowerThumbLayer.setNeedsDisplay()
        
        let upperThumbCenter = CGFloat(positionForValue(value: upperValue))
        upperThumbLayer.frame = CGRect(x: (bounds.width - thumbWidth) / 2, y: upperThumbCenter - thumbWidth/2.0, width: thumbWidth, height: thumbWidth)
        upperThumbLayer.setNeedsDisplay()
        
        setMarkers()
        
        CATransaction.commit()
    }
    
    func positionForValueOfMarker(value: Double) -> Double {
        return Double(bounds.height - markerWidth) * (value - minimumValue) / (maximumValue * Double(tripDays) - minimumValue) + Double(markerWidth / 2.0)
    }
    
    func positionForValue(value: Double) -> Double {
        return Double(bounds.height - thumbWidth) * (value - minimumValue) / (maximumValue * Double(tripDays) - minimumValue) + Double(thumbWidth / 2.0)
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)
        
        if lowerThumbLayer.frame.contains(previousLocation) {
            lowerThumbLayer.highlighted = true
        } else if upperThumbLayer.frame.contains(previousLocation) {
            upperThumbLayer.highlighted = true
        }
        return lowerThumbLayer.highlighted || upperThumbLayer.highlighted
    }
    
    func boundValue(value: Double, toLowerValue lowerValue: Double, upperValue: Double) -> Double {
        return min(max(value, lowerValue), upperValue)
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        let deltaLocation = Double(location.y - previousLocation.y)
        let deltaValue = (maximumValue * Double(tripDays) - minimumValue) * deltaLocation / Double(bounds.height - thumbWidth)
        
        previousLocation = location
        
        if lowerThumbLayer.highlighted {
            lowerValue += deltaValue
            lowerValue = boundValue(value: lowerValue, toLowerValue: minimumValue, upperValue: upperValue)
        } else if upperThumbLayer.highlighted {
            upperValue += deltaValue
            upperValue = boundValue(value: upperValue, toLowerValue: lowerValue, upperValue: maximumValue * Double(tripDays))
        }
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        updateLayerFrames()
        
        CATransaction.commit()
        
        sendActions(for: .valueChanged)
        
        return true
        
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowerThumbLayer.highlighted = false
        upperThumbLayer.highlighted = false
    }
    
    
    
    
    
    
}


















