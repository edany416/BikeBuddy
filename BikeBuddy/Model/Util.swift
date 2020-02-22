//
//  Util.swift
//  BikeBuddy
//
//  Created by Edan on 2/19/20.
//  Copyright © 2020 Edan. All rights reserved.
//

import Foundation
import MapKit

enum Util {
    
    //Dont use this function, color coding route doesnt look very good
    static func makePolylinesWithSpeedGradient(from routePoints: [RoutePoint]) -> ([MKPolyline], [MKPolyline:UIColor]) {
        var polylines = [MKPolyline]()
        var colorForPolylines = [MKPolyline:UIColor]()
        let speedGradient = SpeedGradientGenerator(Color(red: 2, green: 39, blue: 52), 3000, 70)
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
            let polylineColor = speedGradient.colorForSpeed(speed: speed)
            
            polylines.append(polyline)
            colorForPolylines[polyline] = polylineColor
        }
        return (polylines, colorForPolylines)
    }
    
    static func makePolylines(from routePoints: [RoutePoint]) -> ([MKPolyline], [MKPolyline:UIColor]) {
        var polyLines = [MKPolyline]()
        var colorForPolyline = [MKPolyline:UIColor]()
        var routeCoordinates = [CLLocationCoordinate2D]()
        for point in routePoints {
            let coordinate = CLLocationCoordinate2DMake(point.latitude, point.longitute)
            routeCoordinates.append(coordinate)
        }
        let polyline = MKPolyline(coordinates: routeCoordinates, count: routeCoordinates.count)
        polyLines.append(polyline)
        colorForPolyline[polyline] = UIColor.systemRed
        
        return (polyLines, colorForPolyline)
    }
}
