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
    private var points = [RoutePoint]()
    private var frame = RouteFrame()
    
    var routeFrame: RouteFrame {
        return frame
    }
    
    var startingPoint: RoutePoint? {
        return points.first
    }
    
    var endPoint: RoutePoint? {
        return points.last
    }
    
    var distance: Double {
        var sumDistance: Double = 0
        if points.count > 1 {
            for i in 1..<points.count {
                let toPoint = CLLocation(latitude: points[i].latitude , longitude: points[i].longitute)
                let fromPoint = CLLocation(latitude: points[i-1].latitude, longitude: points[i-1].longitute)
                sumDistance += toPoint.distance(from: fromPoint)
            }
        }
        return sumDistance
    }
    
    var routePoints: [RoutePoint] {
        return points
    }
    
    mutating func extendRoute(nextPoint: RoutePoint) {
        points.append(nextPoint)
        frame.adjustFrame(latitude: nextPoint.latitude, longitude: nextPoint.longitute)
    }
    
    mutating func reset() {
        points = [RoutePoint]()
    }
}
