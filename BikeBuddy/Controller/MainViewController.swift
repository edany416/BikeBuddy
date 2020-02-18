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

class MainViewController: UIViewController {
    
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!

    private var locationManager = CLLocationManager()
    private var durationTimer = DurationTimer()
    private var route = Route()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        durationTimer.delegate = self
    }
    
    private var didStartRide = false
    @IBAction func didTapStartStopButton(_ sender: UIButton) {
        if didStartRide == false {
            locationManager.startUpdatingLocation()
            durationTimer.start()
            startStopButton.setTitle("End Ride", for: .normal)
            startStopButton.backgroundColor = UIColor.systemRed
            didStartRide = true
        } else {
            locationManager.stopUpdatingLocation()
            durationTimer.stop()
            startStopButton.setTitle("Start Ride", for: .normal)
            startStopButton.backgroundColor = UIColor.systemGreen
            durationLabel.text = "00:00:00"
            didStartRide = false
            self.performSegue(withIdentifier: "didEndRideSegue", sender: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? RideOverviewViewController {
            destVC.route = route
            if let totalDuration = durationTimer.totalDuration {
                destVC.totalDuration = String().getFormattedTimeString(totalDuration)
            }
            route.reset()
        }
    }
}

extension MainViewController: DurationTimerDelegate {
    func durationDidUpdateWith(_ time: TimeInterval) {
        let formattedTime = String().getFormattedTimeString(time)
        durationLabel.text = formattedTime
    }
}

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last!
        route.addLocation(currentLocation)
        
        let coordinateRegion = MKCoordinateRegion(center: currentLocation.coordinate, latitudinalMeters: 150, longitudinalMeters: 150)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
