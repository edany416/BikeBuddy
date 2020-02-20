//
//  Util.swift
//  BikeBuddy
//
//  Created by Edan on 2/19/20.
//  Copyright © 2020 Edan. All rights reserved.
//

import Foundation
import MapKit

struct RouteSegment {
    var startPoint: RoutePoint
    var endPoint: RoutePoint
}

struct Util {
    static func makePolylines(from routePoints: [RoutePoint]) -> ([MKPolyline], [MKPolyline:UIColor]) {
        var polylines = [MKPolyline]()
        var colorForPolylines = [MKPolyline:UIColor]()
        for i in 1..<routePoints.count {
                        
            let startCoord = CLLocationCoordinate2D(latitude: routePoints[i-1].latitude, longitude: routePoints[i-1].longitute)
            let endCoord = CLLocationCoordinate2D(latitude: routePoints[i].latitude, longitude: routePoints[i].longitute)
            let segmentCoords = [startCoord, endCoord]
            let polyline = MKPolyline(coordinates: segmentCoords, count: segmentCoords.count)
            
            let firstLocation = CLLocation(latitude: routePoints[i-1].latitude, longitude: routePoints[i-1].longitute)
            let secondLocation = CLLocation(latitude: routePoints[i].latitude, longitude: routePoints[i].longitute)
            let distanceTraveled = secondLocation.distance(from: firstLocation)
            let timeToTravalDistance = routePoints[i].timestamp.timeIntervalSince(routePoints[i-1].timestamp)
            let speed = distanceTraveled/timeToTravalDistance
            let polylineColor = UIColor().colorForSpeedInMetersPerSecond(speed)
            
            polylines.append(polyline)
            colorForPolylines[polyline] = polylineColor
        }
        return (polylines, colorForPolylines)
    }
}
