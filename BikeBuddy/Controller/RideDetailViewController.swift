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
        if let fetchedRoute = PersistanceManager.instance.fetchRoute(withID: ride.routeID) {
            route = fetchedRoute
            let metersToMilesConversionRate = 0.00062137
            let distanceInMeters = route.distance
            distanceLabel.text = String(format: "%.2f", distanceInMeters * metersToMilesConversionRate) + "mi"
            configureMap()
            drawRouteOnMap()
        }
    }
    
    private func configureMap() {
        if route.startingPoint != nil {
            let center = CLLocationCoordinate2D(latitude: route.routeFrame.latitudinalCenter, longitude: route.routeFrame.longitudinalCenter)
            mapView.configure(from: MapViewModel(center: center, longitudinalSpread: route.routeFrame.longitudeSpread, latitudinalSpread: route.routeFrame.latitudeSpread))
            mapView.delegate = self
        }
    }

    private var colorForPolylines: [MKPolyline:UIColor]?
    private func drawRouteOnMap() {
        if route.routePoints.count > 1 {
            let drawComponents = Util.makePolylines(from: route.routePoints)
            colorForPolylines = drawComponents.1
            drawComponents.0.forEach({mapView.addOverlay($0)})
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.lineWidth = Constants.routeLineWidth
        renderer.strokeColor = colorForPolylines![polyline]!
        return renderer
    }
}
