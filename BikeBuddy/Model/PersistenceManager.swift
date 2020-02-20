//
//  PersistenceManager.swift
//  BikeBuddy
//
//  Created by Edan on 1/23/20.
//  Copyright © 2020 Edan. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import os

class PersistanceManager {

    // MARK: - Core Data stack
    
    static let instance = PersistanceManager()
    
    private init() { }
    
    
    //Manage context
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "BikeBuddy")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveRide(duration: String, route: Route, routeImage: Data) {
        let cdRoute = CDRoute(context: self.context)
        let points = route.routePoints
        for point in points {
            let cdRoutePoint = CDRoutePoint(context: self.context)
            cdRoutePoint.longitude = point.longitute
            cdRoutePoint.latitude = point.latitude
            cdRoutePoint.timestamp = point.timestamp
            cdRoute.addToPoints(cdRoutePoint)
        }
        
        let cdRide = CDRide(context: self.context)
        cdRide.duration = duration
    
        let cdImage = CDImage(context: self.context)
        cdImage.image = routeImage
        
        let uuid = UUID().uuidString
        cdRide.routeID = uuid
        cdRoute.id = uuid
        cdImage.routeId = uuid
                
        PersistanceManager.instance.saveContext()
    }
    
    func fetchRides() -> [Ride] {
        var fetchedRides: [CDRide]?
        var rides = [Ride]()
        do {
            fetchedRides = try PersistanceManager.instance.context.fetch(CDRide.fetchRequest())
            for ride in fetchedRides! {
                rides.append(Ride(duration: ride.duration, routeID: ride.routeID))
            }
        } catch {
            os_log("Could not fetch rides", log: .default, type: .error)
        }
        return rides
    }
    
    func fetchRoute(withID id: String) -> Route? {
        var route: Route?
        do {
            let fetchRequest: NSFetchRequest<CDRoute> = CDRoute.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id==%@", id)
            let fetchedRoute = try PersistanceManager.instance.context.fetch(fetchRequest)
            if let fRoute = fetchedRoute.first {
                route = Route()
                for point in fRoute.points?.array as! [CDRoutePoint] {
                    let routePoint = RoutePoint(longitute: point.longitude, latitude: point.latitude, timestamp: point.timestamp!)
                    route!.extendRoute(nextPoint: routePoint)
                }
            }
            
        } catch {
            os_log("Could not fetch route with given id", log: .default, type: .error)
        }
        
        return route
    }
    
    func fetchImage(withRouteID id: String) -> [CDImage] {
        var image = [CDImage]()
        do {
            let fetchRequest: NSFetchRequest<CDImage> = CDImage.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "routeId==%@", id)
            image = try PersistanceManager.instance.context.fetch(fetchRequest)
        } catch {
             os_log("Could not fetch image with given id", log: .default, type: .error)
        }
        return image
    }

}
