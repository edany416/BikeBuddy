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
    func configure(from model: MapViewModel) {
        let coordinateRegion = MKCoordinateRegion(center: model.center,
            latitudinalMeters: model.latitudinalSpread,
            longitudinalMeters: model.longitudinalSpread)
        self.setRegion(coordinateRegion, animated: false)
        self.showsUserLocation = false
    }
}
