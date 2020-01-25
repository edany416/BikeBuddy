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
    
    var locationPoints: Int {
        return locationList.count
    }
    
    init() {
        locationList = [CLLocation]()
    }
    
    mutating func addLocation(_ location: CLLocation) {
        locationList.append(location)
    }
    
    func coordinateForLocationPoint(_ index: Int) -> CLLocationCoordinate2D? {
        if index < locationList.count {
            return locationList[index].coordinate
        } else {
            return nil
        }
    }
    
    func speedForLocationPoint(_ index: Int) -> CLLocationSpeed? {
        if index < locationList.count {
            return locationList[index].speed
        } else {
            return nil
        }
    }
    
    mutating func reset() {
        locationList = [CLLocation]()
    }
}
