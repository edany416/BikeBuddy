//
//  CDRide+CoreDataProperties.swift
//  BikeBuddy
//
//  Created by Edan on 1/24/20.
//  Copyright © 2020 Edan. All rights reserved.
//
//

import Foundation
import CoreData


extension CDRide {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDRide> {
        return NSFetchRequest<CDRide>(entityName: "CDRide")
    }

    @NSManaged public var routeID: String
    @NSManaged public var duration: String
    @NSManaged public var date: String

}
