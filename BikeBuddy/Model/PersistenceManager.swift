//
//  PersistenceManager.swift
//  BikeBuddy
//
//  Created by Edan on 1/23/20.
//  Copyright © 2020 Edan. All rights reserved.
//

import Foundation
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
    
    func saveRide(duration: String, route: Route) {
        let cdRoute = CDRoute(context: self.context)
        let locations = route.allLocations
        for location in locations {
            let cdLocation = CDLocation(context: self.context)
            cdLocation.longitude = location.coordinate.longitude
            cdLocation.latitude = location.coordinate.latitude
            cdLocation.speed = location.speed
            cdRoute.addToLocations(cdLocation)
        }
        
        cdRoute.totalDistance = route.totalDistance
        cdRoute.startPointLatitude = route.startingPoint!.latitude
        cdRoute.startPointLongitude = route.startingPoint!.longitude
        
        let cdRide = CDRide(context: self.context)
        cdRide.route = cdRoute
        cdRide.duration = duration
        
        PersistanceManager.instance.saveContext()
    }
    
    func fetchRides(given fetchRequest: NSFetchRequest<CDRide>) -> [CDRide]? {
        var rides: [CDRide]?
        do {
            rides = try PersistanceManager.instance.context.fetch(fetchRequest)
        } catch {
            os_log("Could not fetch rides", log: .default, type: .error)
        }
        return rides ?? nil
    }

}
