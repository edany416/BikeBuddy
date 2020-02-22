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
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var routeThumbnail: UIImageView!
    @IBOutlet private weak var imageContainerView: UIView!
    
    func configureCell(from model: RideListCellModel) {
        dateLabel.text = model.date
        if let image = UIImage(data: model.routeImage) {
            routeThumbnail.image = imageWithImage(image: image, scaledToSize: routeThumbnail.bounds.size)
        }
    }
    
    private func imageWithImage(image: UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
