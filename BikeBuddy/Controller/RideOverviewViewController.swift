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
    
    @IBOutlet weak var testImageView: UIImageView!
    
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
            let center = CLLocationCoordinate2D(latitude: route.routeFrame.latitudinalCenter, longitude: route.routeFrame.longitudinalCenter)
            mapView.configure(from: MapViewModel(center: center, longitudinalSpread: route.routeFrame.longitudeSpread, latitudinalSpread: route.routeFrame.latitudeSpread))
            mapView.delegate = self
        }
    }
    
    private var colorForPolylines: [MKPolyline:UIColor]?
    private func drawRouteOnMap() {
        if route.routePoints.count > 1 {
            let (polylines, colors) = Util.makePolylines(from: route.routePoints)
            colorForPolylines = colors
            polylines.forEach({mapView.addOverlay($0)})
        }
    }
    
    @IBAction func didTapSaveRide(_ sender: Any) {
        
        let renderer = UIGraphicsImageRenderer(size: mapView.bounds.size)
        let image = renderer.image { ctx in mapView.drawHierarchy(in: mapView.bounds, afterScreenUpdates: true)}
        
        PersistanceManager.instance.saveRide(duration: totalDuration, route: route, routeImage: image.pngData()!)
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

