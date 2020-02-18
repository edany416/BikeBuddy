//
//  Route.swift
//  BikeBuddy
//
//  Created by Edan on 1/23/20.
//  Copyright © 2020 Edan. All rights reserved.
//

import Foundation
import CoreLocation

struct Route {
    
    private var locationList: [CLLocation]
    
    var allLocations: [CLLocation] {
        get {
            return locationList
        }
    }
    
    var startingPoint: CLLocationCoordinate2D? {
        if locationList.count > 0 {
            return locationList[0].coordinate
        } else {
            return nil
        }
    }
    
    var totalDistance: Double {
        var sumDistance = Double()
        var tail = 0
        var head = 1
        if locationList.count > 1 {
            while head < locationList.count {
                sumDistance += locationList[head].distance(from: locationList[tail])
                tail += 1
                head += 1
            }
            return sumDistance
        } else {
            return 0
        }
    }
    
    init() {
        locationList = [CLLocation]()
    }
    
    mutating func addLocation(_ location: CLLocation) {
        locationList.append(location)
    }
    
    mutating func reset() {
        locationList = [CLLocation]()
    }
}
