//
//  MapMarker.swift
//  DeindeApp
//
//  Created by Juliya on 22.07.17.
//  Copyright © 2017 Andrey Krit. All rights reserved.
//

import Foundation
import GoogleMaps

class MapMarker {
    let marker: GMSMarker
    var timeGl = ""
    var totalTime: Int?
    
    init(position: CLLocationCoordinate2D, time: String, map: GMSMapView, totalTimeOfPlace: Int) {
        marker = GMSMarker(position: position)
        let markerImage = UIImage(named: "marker")
        marker.iconView = UIImageView(image: drawText(text: time + ":00", inImage: markerImage!))
        marker.map = map
        timeGl = time
        totalTime = totalTimeOfPlace
    }
    
    func drawText(text: String, inImage: UIImage) -> UIImage? {
        
        let font = UIFont.systemFont(ofSize: 11)
        let size = inImage.size
        
        UIGraphicsBeginImageContext(size)
        
        inImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let style : NSMutableParagraphStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        style.alignment = .center
        let attributes:NSDictionary = [ NSFontAttributeName : font, NSParagraphStyleAttributeName : style, NSForegroundColorAttributeName : UIColor.white ]
        
        let textSize = text.size(attributes: attributes as? [String : Any])
        let rect = CGRect(x: 0, y: 0, width: inImage.size.width, height: inImage.size.height)
        let textRect = CGRect(x: (rect.size.width - textSize.width)/2, y: (rect.size.height - textSize.height)/2 - 4, width: textSize.width, height: textSize.height)
        text.draw(in: textRect.integral, withAttributes: attributes as? [String : Any])
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return resultImage
    }
    
    func hideMarker() {
        marker.map = nil
    }
    
    func showMarker(map: GMSMapView) {
        marker.map = map
    }
    
    
    
    
}
