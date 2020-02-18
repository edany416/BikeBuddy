//
//  CDRoute+CoreDataProperties.swift
//  BikeBuddy
//
//  Created by Edan on 2/18/20.
//  Copyright © 2020 Edan. All rights reserved.
//
//

import Foundation
import CoreData


extension CDRoute {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDRoute> {
        return NSFetchRequest<CDRoute>(entityName: "CDRoute")
    }

    @NSManaged public var startPointLatitude: Double
    @NSManaged public var startPointLongitude: Double
    @NSManaged public var totalDistance: Double
    @NSManaged public var locations: NSOrderedSet?
}

// MARK: Generated accessors for locations
extension CDRoute {

    @objc(insertObject:inLocationsAtIndex:)
    @NSManaged public func insertIntoLocations(_ value: CDLocation, at idx: Int)

    @objc(removeObjectFromLocationsAtIndex:)
    @NSManaged public func removeFromLocations(at idx: Int)

    @objc(insertLocations:atIndexes:)
    @NSManaged public func insertIntoLocations(_ values: [CDLocation], at indexes: NSIndexSet)

    @objc(removeLocationsAtIndexes:)
    @NSManaged public func removeFromLocations(at indexes: NSIndexSet)

    @objc(replaceObjectInLocationsAtIndex:withObject:)
    @NSManaged public func replaceLocations(at idx: Int, with value: CDLocation)

    @objc(replaceLocationsAtIndexes:withLocations:)
    @NSManaged public func replaceLocations(at indexes: NSIndexSet, with values: [CDLocation])

    @objc(addLocationsObject:)
    @NSManaged public func addToLocations(_ value: CDLocation)

    @objc(removeLocationsObject:)
    @NSManaged public func removeFromLocations(_ value: CDLocation)

    @objc(addLocations:)
    @NSManaged public func addToLocations(_ values: NSOrderedSet)

    @objc(removeLocations:)
    @NSManaged public func removeFromLocations(_ values: NSOrderedSet)

}
