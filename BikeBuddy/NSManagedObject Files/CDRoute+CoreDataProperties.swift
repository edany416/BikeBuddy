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

    @NSManaged public var id: String
    @NSManaged public var points: NSOrderedSet?
    

}

// MARK: Generated accessors for points
extension CDRoute {

    @objc(insertObject:inPointsAtIndex:)
    @NSManaged public func insertIntoPoints(_ value: CDRoutePoint, at idx: Int)

    @objc(removeObjectFromPointsAtIndex:)
    @NSManaged public func removeFromPoints(at idx: Int)

    @objc(insertPoints:atIndexes:)
    @NSManaged public func insertIntoPoints(_ values: [CDRoutePoint], at indexes: NSIndexSet)

    @objc(removePointsAtIndexes:)
    @NSManaged public func removeFromPoints(at indexes: NSIndexSet)

    @objc(replaceObjectInPointsAtIndex:withObject:)
    @NSManaged public func replacePoints(at idx: Int, with value: CDRoutePoint)

    @objc(replacePointsAtIndexes:withPoints:)
    @NSManaged public func replacePoints(at indexes: NSIndexSet, with values: [CDRoutePoint])

    @objc(addPointsObject:)
    @NSManaged public func addToPoints(_ value: CDRoutePoint)

    @objc(removePointsObject:)
    @NSManaged public func removeFromPoints(_ value: CDRoutePoint)

    @objc(addPoints:)
    @NSManaged public func addToPoints(_ values: NSOrderedSet)

    @objc(removePoints:)
    @NSManaged public func removeFromPoints(_ values: NSOrderedSet)

}
