//
//  RideDetailViewController.swift
//  BikeBuddy
//
//  Created by Edan on 1/25/20.
//  Copyright © 2020 Edan. All rights reserved.
//

import UIKit
import MapKit

class RideDetailViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var ride: Ride!
    var route: Route!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        durationLabel.text = ride.duration
        if let fetchedRoute = PersistanceManager.instance.fetchRoute(withID: ride.routeID!) {
            route = fetchedRoute
            let metersToMilesConversionRate = 0.00062137
            let distanceInMeters = route.distance
            distanceLabel.text = String(format: "%.2f", distanceInMeters * metersToMilesConversionRate) + "mi"
            
            if let start = route.startingPoint {
                let startCoord = CLLocationCoordinate2D(latitude: start.latitude, longitude: start.longitute)
                let coordinateRegion = MKCoordinateRegion(center: startCoord, latitudinalMeters: 400, longitudinalMeters: 400)
                mapView.setRegion(coordinateRegion, animated: false)
            }
        }
        
        mapView.delegate = self
        mapView.showsUserLocation = false
       
        drawRouteOnMap()
    }

    private var routeSegment: RouteSegment?
    private func drawRouteOnMap() {
        let routePoints = route.routePoints
        if routePoints.count > 1 {
            for i in 1..<routePoints.count {
                routeSegment = RouteSegment(startPoint: routePoints[i-1], endPoint: routePoints[i])
                let startCoord = CLLocationCoordinate2D(latitude: routeSegment!.startPoint.latitude, longitude: routeSegment!.startPoint.longitute)
                let endCoord = CLLocationCoordinate2D(latitude: routeSegment!.endPoint.latitude, longitude: routeSegment!.endPoint.longitute)
                let segmentCoords = [startCoord, endCoord]
                let polyline = MKPolyline(coordinates: segmentCoords, count: segmentCoords.count)
                mapView.addOverlay(polyline)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.lineWidth = 2
        
        let firstLocation = CLLocation(latitude: routeSegment!.startPoint.latitude, longitude: routeSegment!.startPoint.longitute)
        let secondLocation = CLLocation(latitude: routeSegment!.endPoint.latitude, longitude: routeSegment!.endPoint.longitute)

        let distanceTraveled = secondLocation.distance(from: firstLocation)
        let timeToTravalDistance = routeSegment!.endPoint.timestamp.timeIntervalSince(routeSegment!.startPoint.timestamp)

        let speed = distanceTraveled/timeToTravalDistance
        renderer.strokeColor = UIColor().colorForSpeedInMetersPerSecond(speed)

        return renderer
    }
}
