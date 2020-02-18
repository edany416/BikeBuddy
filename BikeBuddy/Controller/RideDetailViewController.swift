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
    
    var ride: CDRide!

    override func viewDidLoad() {
        super.viewDidLoad()
        durationLabel.text = ride.duration
        
        let distanceInMeters = ride.route!.totalDistance
        let metersToMilesConversionRate = 0.00062137
        distanceLabel.text = String(format: "%.2f", distanceInMeters * metersToMilesConversionRate) + "mi"
        
        let startingPoint = CLLocationCoordinate2DMake(ride.route!.startPointLatitude, ride.route!.startPointLongitude)
        let coordinateRegion = MKCoordinateRegion(center: startingPoint, latitudinalMeters: 400, longitudinalMeters: 400)
        
        mapView.setRegion(coordinateRegion, animated: false)
        mapView.delegate = self
        mapView.showsUserLocation = false
       
        drawRouteOnMap()
    }

    var routeSegment = [CDLocation]()
    private func drawRouteOnMap() {
        let locations = ride.route!.locations?.array as! [CDLocation]
        for location in locations {
            if routeSegment.count < 2 {
                routeSegment.append(location)
                continue
            }
            
            drawRouteSegment(segment: routeSegment)
            
            let temp = routeSegment[1]
            routeSegment[0] = temp
            routeSegment[1] = location
        }
        
        drawRouteSegment(segment: routeSegment)
    }
    
    private func drawRouteSegment(segment: [CDLocation]) {
        let segmentStart = CLLocationCoordinate2DMake(segment[0].latitude, segment[0].longitude)
        let segmentEnd = CLLocationCoordinate2DMake(segment[1].latitude, segment[1].longitude)
        let segmentCoordinates = [segmentStart,segmentEnd]
        let polyRoute = MKPolyline(coordinates: segmentCoordinates, count: segmentCoordinates.count)
        mapView.addOverlay(polyRoute)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.lineWidth = 2
        
        let firstSpeed = routeSegment[0].speed
        let secondSpeed = routeSegment[1].speed
        let averageSpeed = (firstSpeed + secondSpeed)/2
        renderer.strokeColor = UIColor().colorForSpeedInMetersPerSecond(averageSpeed)

        return renderer
    }
}
