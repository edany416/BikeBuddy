//
//  MainViewController.swift
//  BikeBuddy
//
//  Created by Edan on 1/23/20.
//  Copyright © 2020 Edan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MainViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!

    private var locationManager = CLLocationManager()
    private var durationTimer = DurationTimer()
    private var route = Route()
    
    private var coordinates: [CLLocationCoordinate2D]?
    private var speeds: [CLLocationSpeed]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        mapView.delegate = self
        
        durationTimer.delegate = self
    }
    
    private var didStartRide = false
    @IBAction func didTapStartStopButton(_ sender: UIButton) {
        if didStartRide == false {
            locationManager.startUpdatingLocation()
            durationTimer.start()
            startStopButton.setTitle("End Ride", for: .normal)
            didStartRide = true
        } else {
            startStopButton.setTitle("StartRide", for: .normal)
            didStartRide = false
            durationTimer.stop()
            locationManager.stopUpdatingLocation()
            
            //let ride = Ride(duration: durationTimer.totalDuration!, route: route)
            
            coordinates = route.allCoordinates()
            speeds = route.allSpeeds()
            //drawRouteOnMap(ride)
        }
        
    }
    
    private func getSecondsMinutesHours(from seconds: TimeInterval) -> (Int, Int, Int) {
        let roundedSeconds = Int(seconds)
        return ((roundedSeconds % 3600) % 60, (roundedSeconds % 3600) / 60, roundedSeconds / 3600)
    }
    
    private var tail = 0
    private var head = 1
//    private func drawRouteOnMap(_ ride: Ride) {
//        if coordinates != nil && speeds != nil && coordinates!.count > 1  {
//            while head < coordinates!.count {
//                let currentCoordinates = [coordinates![tail], coordinates![head]]
//                let polyRoute = MKPolyline(coordinates: currentCoordinates, count: currentCoordinates.count)
//                mapView.addOverlay(polyRoute)
//                tail += 1
//                head += 1
//            }
//        }
//    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let firstSpeed = speeds![tail]
        let secondSpeed = speeds![head]
        let averageSpeed = (firstSpeed+secondSpeed)/2
        
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.lineWidth = 2
        renderer.strokeColor = UIColor().colorForSpeedInMetersPerSecond(averageSpeed)
        
        return renderer
    }
    
    
}

extension MainViewController: DurationTimerDelegate {
    func durationDidUpdateWith(_ time: TimeInterval) {
        let timeComponents = getSecondsMinutesHours(from: time)
        let formattedTime = String().getFormattedTimeString(hours: timeComponents.2, minutes: timeComponents.1, seconds: timeComponents.0)
        durationLabel.text = formattedTime
        
    }
}

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last!
        route.addCoordinateSpeedPair(currentLocation.coordinate, currentLocation.speed)
        
        let coordinateRegion = MKCoordinateRegion(center: currentLocation.coordinate, latitudinalMeters: 150, longitudinalMeters: 150)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
