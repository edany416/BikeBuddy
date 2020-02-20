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
        let distance = route.distance
        let metersToMileConversionRate = 0.000621371
        distanceLabel.text = String(format: "%.2f", distance * metersToMileConversionRate) + "mi"
        configureMap()
        drawRouteOnMap()
    }
    
    private func configureMap() {
        if route.startingPoint != nil {
            mapView.configure(from: route)
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
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.lineWidth = 2
        renderer.strokeColor = colorForPolylines![polyline]!
        return renderer
    }
}

