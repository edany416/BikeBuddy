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
    
    private var tail = 0
    private var head = 1
    private var totalDistance = Double()
    private func drawRouteOnMap() {
        while route!.coordinateForLocationPoint(head) != nil {
            let currentCoordinates =
                [route.coordinateForLocationPoint(tail)!, route.coordinateForLocationPoint(head)!]
            let polyRoute = MKPolyline(coordinates: currentCoordinates, count: currentCoordinates.count)
            mapView.addOverlay(polyRoute)
        }
    }
    
    @IBAction func didTapSaveRide(_ sender: Any) {
        PersistanceManager.instance.saveRide(totalDuration, route: route)
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
    
        let firstSpeed = route.speedForLocationPoint(tail)!
        let secondSpeed = route.speedForLocationPoint(head)!
        let averageSpeed = (firstSpeed+secondSpeed)/2
        renderer.strokeColor = UIColor().colorForSpeedInMetersPerSecond(averageSpeed)
        
        tail += 1
        head += 1
        
        return renderer
    }
}

