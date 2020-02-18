//
//  RideOverviewViewController.swift
//  BikeBuddy
//
//  Created by Edan on 1/23/20.
//  Copyright © 2020 Edan. All rights reserved.
//

import UIKit
import MapKit

class RideOverviewViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var route: Route!
    var totalDuration: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        durationLabel.text = totalDuration
        let distance = route.totalDistance
        let metersToMileConversionRate = 0.000621371
        distanceLabel.text = String(format: "%.2f", distance * metersToMileConversionRate) + "mi"
    
        mapView.showsUserLocation = false
        let coordinateRegion = MKCoordinateRegion(center: route.startingPoint!,
                                                  latitudinalMeters: 400,
                                                  longitudinalMeters: 400)
        mapView.setRegion(coordinateRegion, animated: false)
        mapView.delegate = self
        drawRouteOnMap()
    }
    
    private var routeSegment = [CLLocation]()
    private func drawRouteOnMap() {
        let routeLocations = route!.allLocations
        
        if routeLocations.count < 2 {
            return
        }
        
        for location in routeLocations {
            if routeSegment.count < 2 {
                routeSegment.append(location)
                continue
            }
            
            drawSegmentLine(routeSegment)
            
            let temp = routeSegment[1]
            routeSegment[0] = temp
            routeSegment[1] = location
        }
        drawSegmentLine(routeSegment)
    }
    
    private func drawSegmentLine(_ segment: [CLLocation]) {
        let segmentCoordinates = [segment[0].coordinate, segment[1].coordinate]
        let polyRoute = MKPolyline(coordinates: segmentCoordinates, count: segmentCoordinates.count)
        mapView.addOverlay(polyRoute)
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
    
        let firstSpeed = routeSegment[0].speed
        let secondSpeed = routeSegment[1].speed
        let averageSpeed = (firstSpeed+secondSpeed)/2
        renderer.strokeColor = UIColor().colorForSpeedInMetersPerSecond(averageSpeed)
        
        return renderer
    }
}

