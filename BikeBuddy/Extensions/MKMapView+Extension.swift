//
//  MKMapView+Extension.swift
//  BikeBuddy
//
//  Created by Edan on 2/19/20.
//  Copyright © 2020 Edan. All rights reserved.
//

import Foundation
import MapKit

extension MKMapView {
    func configure(from route: Route) {
        let coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: route.routeFrame.latitudinalCenter, longitude: route.routeFrame.longitudinalCenter),
            latitudinalMeters: route.routeFrame.latitudeSpread,
            longitudinalMeters: route.routeFrame.longitudeSpread)
        self.setRegion(coordinateRegion, animated: false)
        self.showsUserLocation = false
    }
}
