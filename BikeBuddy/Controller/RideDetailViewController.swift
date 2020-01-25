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
    
    var ride: CDRide! {
        didSet {
            numCoordinates = ride.route!.coordinateList!.count
            coordinateList = ride.route!.coordinateList!.array as? [CDCoordinate]
            speedList = ride.route!.speedList!.array as? [CDSpeed]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        durationLabel.text = ride.duration
        let distanceInMeters = ride.route!.totalDistance
        let metersToMilesConversionRate = 0.00062137
        distanceLabel.text = String(format: "%.2f", distanceInMeters * metersToMilesConversionRate) + "mi"
        mapView.showsUserLocation = false
        let startingPoint = CLLocationCoordinate2DMake(ride.route!.startPointLatitude, ride.route!.startPointLongitude)
        let coordinateRegion = MKCoordinateRegion(center: startingPoint, latitudinalMeters: 400, longitudinalMeters: 400)
        mapView.setRegion(coordinateRegion, animated: false)
        mapView.delegate = self
        drawRouteOnMap()
    }
    
    private var tail = 0
    private var head = 1
    private var numCoordinates: Int!
    private var coordinateList: [CDCoordinate]!
    private var speedList: [CDSpeed]!
    private func drawRouteOnMap() {
        while head < numCoordinates {
            let firstCoordinate = CLLocationCoordinate2DMake(coordinateList[tail].latitude, coordinateList[tail].longitude)
            let secondCoordinate = CLLocationCoordinate2DMake(coordinateList[head].latitude, coordinateList[head].longitude)
            let currentCoordinates = [firstCoordinate, secondCoordinate]
            let polyRoute = MKPolyline(coordinates: currentCoordinates, count: currentCoordinates.count)
            mapView.addOverlay(polyRoute)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.lineWidth = 2
        let firstSpeed = speedList[tail].speedMPS
        let secondSpeed = speedList[head].speedMPS
        let averageSpeed = (firstSpeed + secondSpeed)/2
        renderer.strokeColor = UIColor().colorForSpeedInMetersPerSecond(averageSpeed)
        
        tail += 1
        head += 1
        
        return renderer
    }
}
