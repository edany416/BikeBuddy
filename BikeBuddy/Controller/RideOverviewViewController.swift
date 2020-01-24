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
    
    //Should create the ride in the previous VC, then all have instance of that
    //ride here with all the needed info
    //Finally save ride with save context if save is tapped
    var route: Route!
    var totalDuration: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        durationLabel.text = totalDuration
        if let distance = route.totalDistance {
            distanceLabel.text = String(distance)
        }
        mapView.showsUserLocation = false
        let coordinateRegion = MKCoordinateRegion(center: route.startingPoint!, latitudinalMeters: 400, longitudinalMeters: 400)
        mapView.setRegion(coordinateRegion, animated: false)
        mapView.delegate = self
        drawRouteOnMap()
    }
    
    private var tail = 0
    private var head = 1
    private var totalDistance = Double()
    private func drawRouteOnMap() {
        while route!.coordinateForLocationPoint(head) != nil {
            let currentCoordinates = [route.coordinateForLocationPoint(tail)!, route.coordinateForLocationPoint(head)!]
            let polyRoute = MKPolyline(coordinates: currentCoordinates, count: currentCoordinates.count)
            mapView.addOverlay(polyRoute)

            tail += 1
            head += 1
        }
    }
}

extension RideOverviewViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let firstSpeed = route!.speedForLocationPoint(tail)!
        let secondSpeed = route!.speedForLocationPoint(head)!
        let averageSpeed = (firstSpeed+secondSpeed)/2
          
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.lineWidth = 2
        renderer.strokeColor = UIColor().colorForSpeedInMetersPerSecond(averageSpeed)
          
        return renderer
    }
}

