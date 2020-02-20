//
//  RouteFrame.swift
//  BikeBuddy
//
//  Created by Edan on 2/19/20.
//  Copyright © 2020 Edan. All rights reserved.
//

import Foundation
import CoreLocation

struct RouteFrame {
    
    var latitudeSpread: Double {
        let midPoint = abs(maxLongitude+minLongitude)/2
        let leftPoint = CLLocation(latitude: minLatitude, longitude: midPoint)
        let rightPoint = CLLocation(latitude: maxLatitude, longitude: midPoint)
        return rightPoint.distance(from: leftPoint)
    }
    
    var longitudeSpread: Double {
        let midPoint = abs(maxLatitude + minLatitude)/2
        let bottomPoint = CLLocation(latitude: midPoint, longitude: minLongitude)
        let topPoint = CLLocation(latitude: midPoint, longitude: maxLongitude)
        return topPoint.distance(from: bottomPoint)
    }
    
    var latitudinalCenter: Double {
        return (maxLatitude + minLatitude)/2
    }
    
    var longitudinalCenter: Double {
        return (maxLongitude+minLongitude)/2
    }
    
    private var minLatitude = Double(Int.max)
    private var maxLatitude = Double(Int.min)
    
    private var minLongitude = Double(Int.max)
    private var maxLongitude = Double(Int.min)
    
    mutating func adjustFrame(latitude: Double, longitude: Double) {
        if latitude <= minLatitude {
            minLatitude = latitude
        } else if latitude > maxLatitude {
            maxLatitude = latitude
        }
        
        if longitude <= minLongitude {
            minLongitude = longitude
        } else if longitude > maxLongitude {
            maxLongitude = longitude
        }
    }
}
