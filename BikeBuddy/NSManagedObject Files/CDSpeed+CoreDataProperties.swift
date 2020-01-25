//
//  CDSpeed+CoreDataProperties.swift
//  BikeBuddy
//
//  Created by Edan on 1/24/20.
//  Copyright © 2020 Edan. All rights reserved.
//
//

import Foundation
import CoreData


extension CDSpeed {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDSpeed> {
        return NSFetchRequest<CDSpeed>(entityName: "CDSpeed")
    }

    @NSManaged public var speedMPS: Double

}
