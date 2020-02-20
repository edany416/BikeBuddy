//
//  RideListTableViewCell.swift
//  BikeBuddy
//
//  Created by Edan on 2/19/20.
//  Copyright © 2020 Edan. All rights reserved.
//

import UIKit
import MapKit

struct RideListCellModel {
    let date: String
    let routeImage: Data
    
}

class RideListTableViewCell: UITableViewCell, MKMapViewDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet private weak var routeThumbnail: UIImageView!
    
    func configureCell(from model: RideListCellModel) {
        let image = UIImage(data: model.routeImage)
        
        let scale = 150 / image!.size.width
        let newHeight = image!.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: 150, height: newHeight))
        image!.draw(in: CGRect(x: 0, y: 0, width: 150, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        
        
        
        routeThumbnail.image = newImage
        
    }
    
//    private var colorForPolylines: [MKPolyline:UIColor]?
//    private func drawRouteOnMap() {
//        if route.routePoints.count > 1 {
//            let drawComponents = Util.makePolylines(from: route.routePoints)
//            colorForPolylines = drawComponents.1
//            drawComponents.0.forEach({mapView.addOverlay($0)})
//        }
//    }
//
//    internal func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        let polyline = overlay as! MKPolyline
//        let renderer = MKPolylineRenderer(polyline: polyline)
//        renderer.lineWidth = 2
//        renderer.strokeColor = colorForPolylines![polyline]!
//        return renderer
//    }
}
