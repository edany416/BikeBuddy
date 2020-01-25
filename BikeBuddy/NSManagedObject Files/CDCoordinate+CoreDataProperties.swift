//
//  CDCoordinate+CoreDataProperties.swift
//  BikeBuddy
//
//  Created by Edan on 1/24/20.
//  Copyright © 2020 Edan. All rights reserved.
//
//

import Foundation
import CoreData


extension CDCoordinate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCoordinate> {
        return NSFetchRequest<CDCoordinate>(entityName: "CDCoordinate")
    }

    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double

}
