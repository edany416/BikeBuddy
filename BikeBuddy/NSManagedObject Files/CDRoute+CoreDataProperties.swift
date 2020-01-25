//
//  CDRoute+CoreDataProperties.swift
//  BikeBuddy
//
//  Created by Edan on 1/24/20.
//  Copyright © 2020 Edan. All rights reserved.
//
//

import Foundation
import CoreData


extension CDRoute {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDRoute> {
        return NSFetchRequest<CDRoute>(entityName: "CDRoute")
    }

    @NSManaged public var totalDistance: Double
    @NSManaged public var startPointLatitude: Double
    @NSManaged public var startPointLongitude: Double
    @NSManaged public var coordinateList: NSOrderedSet?
    @NSManaged public var speedList: NSOrderedSet?

}

// MARK: Generated accessors for coordinateList
extension CDRoute {

    @objc(insertObject:inCoordinateListAtIndex:)
    @NSManaged public func insertIntoCoordinateList(_ value: CDCoordinate, at idx: Int)

    @objc(removeObjectFromCoordinateListAtIndex:)
    @NSManaged public func removeFromCoordinateList(at idx: Int)

    @objc(insertCoordinateList:atIndexes:)
    @NSManaged public func insertIntoCoordinateList(_ values: [CDCoordinate], at indexes: NSIndexSet)

    @objc(removeCoordinateListAtIndexes:)
    @NSManaged public func removeFromCoordinateList(at indexes: NSIndexSet)

    @objc(replaceObjectInCoordinateListAtIndex:withObject:)
    @NSManaged public func replaceCoordinateList(at idx: Int, with value: CDCoordinate)

    @objc(replaceCoordinateListAtIndexes:withCoordinateList:)
    @NSManaged public func replaceCoordinateList(at indexes: NSIndexSet, with values: [CDCoordinate])

    @objc(addCoordinateListObject:)
    @NSManaged public func addToCoordinateList(_ value: CDCoordinate)

    @objc(removeCoordinateListObject:)
    @NSManaged public func removeFromCoordinateList(_ value: CDCoordinate)

    @objc(addCoordinateList:)
    @NSManaged public func addToCoordinateList(_ values: NSOrderedSet)

    @objc(removeCoordinateList:)
    @NSManaged public func removeFromCoordinateList(_ values: NSOrderedSet)

}

// MARK: Generated accessors for speedList
extension CDRoute {

    @objc(insertObject:inSpeedListAtIndex:)
    @NSManaged public func insertIntoSpeedList(_ value: CDSpeed, at idx: Int)

    @objc(removeObjectFromSpeedListAtIndex:)
    @NSManaged public func removeFromSpeedList(at idx: Int)

    @objc(insertSpeedList:atIndexes:)
    @NSManaged public func insertIntoSpeedList(_ values: [CDSpeed], at indexes: NSIndexSet)

    @objc(removeSpeedListAtIndexes:)
    @NSManaged public func removeFromSpeedList(at indexes: NSIndexSet)

    @objc(replaceObjectInSpeedListAtIndex:withObject:)
    @NSManaged public func replaceSpeedList(at idx: Int, with value: CDSpeed)

    @objc(replaceSpeedListAtIndexes:withSpeedList:)
    @NSManaged public func replaceSpeedList(at indexes: NSIndexSet, with values: [CDSpeed])

    @objc(addSpeedListObject:)
    @NSManaged public func addToSpeedList(_ value: CDSpeed)

    @objc(removeSpeedListObject:)
    @NSManaged public func removeFromSpeedList(_ value: CDSpeed)

    @objc(addSpeedList:)
    @NSManaged public func addToSpeedList(_ values: NSOrderedSet)

    @objc(removeSpeedList:)
    @NSManaged public func removeFromSpeedList(_ values: NSOrderedSet)

}
