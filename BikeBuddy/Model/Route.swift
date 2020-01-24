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
    private var coordinates: [CLLocationCoordinate2D]
    private var speeds: [CLLocationSpeed]
    private var coordinateSpeedPairs: [(CLLocationCoordinate2D,CLLocationSpeed)]
    
    
    init() {
        coordinates = [CLLocationCoordinate2D]()
        speeds = [CLLocationSpeed]()
        coordinateSpeedPairs = [(CLLocationCoordinate2D, CLLocationSpeed)]()
        
    }
    
//    mutating func addCoordinate(_ coordinate: CLLocationCoordinate2D) {
//        coordinates.append(coordinate)
//    }
    
    mutating func addCoordinateSpeedPair(_ coordinate: CLLocationCoordinate2D, _ speed: CLLocationSpeed) {
        coordinates.append(coordinate)
        speeds.append(speed)
        coordinateSpeedPairs.append((coordinate,speed))
    }
    
    func allCoordinates() -> [CLLocationCoordinate2D] {
        return coordinates
    }
    
    func allSpeeds() -> [CLLocationSpeed] {
        return speeds
    }
}
