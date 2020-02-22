//
//  RidesListViewController.swift
//  BikeBuddy
//
//  Created by Edan on 1/25/20.
//  Copyright © 2020 Edan. All rights reserved.
//

import UIKit
import CoreLocation

class RidesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ridesTableView: UITableView!

    private var rides:[CDRide] = [CDRide]() {
        didSet {
            if ridesTableView != nil {
                self.ridesTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ridesTableView.dataSource = self
        ridesTableView.delegate = self
        retrieveData()
        NotificationCenter.default.addObserver(self,
        selector: #selector(contextDidSave(_:)),
        name: Notification.Name.NSManagedObjectContextDidSave,
        object: nil)
    }
    
    @objc func contextDidSave(_ notification: Notification) {
        retrieveData()
    }
    
    private func retrieveData() {
        rides = PersistanceManager.instance.fetchRides()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rides.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ridesTableView.dequeueReusableCell(withIdentifier: "RideListCell", for: indexPath) as! RideListTableViewCell
        let ride = rides[indexPath.row]
        let routeId = ride.routeID
        let image = PersistanceManager.instance.fetchImage(withRouteID: routeId)
        cell.configureCell(from: RideListCellModel(date: ride.date, routeImage: image[0].image!))
        
        return cell
    }
    
    private var selectedRide: Ride?
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ride = Ride(duration: rides[indexPath.row].duration,
                        routeID: rides[indexPath.row].routeID,
                        date: rides[indexPath.row].date)
        selectedRide = ride
        self.performSegue(withIdentifier: "ShowRideDetailSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRideDetailSegue" {
            if let destVC = segue.destination as? RideDetailViewController {
                destVC.ride = selectedRide!
            }
        }
    }
}
