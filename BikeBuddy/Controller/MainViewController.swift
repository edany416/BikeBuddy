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
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
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
    
    @IBAction func coreDataTest(_ sender: Any) {
        let rides = PersistanceManager.instance.fetchRides(given: CDRide.fetchRequest())
        for ride in rides! {
            print("\(ride.duration)")
            if let route = ride.route {
                print("Route")
                if let speedList = route.speedList?.array as? [CDSpeed] {
                    print("Speeds")
                    for speed in speedList {
                        print("\(speed.speedMPS)")
                    }
                }
                
                if let coordList = route.coordinateList?.array as? [CDCoordinate] {
                    for c in coordList {
                        print("\(c.latitude)")
                        print("\(c.longitude)")
                    }
                }
            }
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
}
