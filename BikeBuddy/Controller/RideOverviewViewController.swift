//
//  RideOverviewViewController.swift
//  BikeBuddy
//
//  Created by Edan on 1/23/20.
//  Copyright © 2020 Edan. All rights reserved.
//

import UIKit
import MapKit

struct RouteSegment {
    var startPoint: RoutePoint
    var endPoint: RoutePoint
}

class RideOverviewViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var route: Route!
    var totalDuration: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        durationLabel.text = totalDuration
        let distance = route.distance
        let metersToMileConversionRate = 0.000621371
        distanceLabel.text = String(format: "%.2f", distance * metersToMileConversionRate) + "mi"
    
        if let startPoint = route.startingPoint {
            let coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: startPoint.latitude, longitude: startPoint.longitute),
                latitudinalMeters: 400,
                longitudinalMeters: 400)
            mapView.setRegion(coordinateRegion, animated: false)
            mapView.showsUserLocation = false
            mapView.delegate = self
        }
       
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
    
    @IBAction func didTapSaveRide(_ sender: Any) {
        PersistanceManager.instance.saveRide(duration: totalDuration, route: route)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension RideOverviewViewController: MKMapViewDelegate {
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

