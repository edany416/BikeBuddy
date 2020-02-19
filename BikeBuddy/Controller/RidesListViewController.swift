//
//  RidesListViewController.swift
//  BikeBuddy
//
//  Created by Edan on 1/25/20.
//  Copyright © 2020 Edan. All rights reserved.
//

import UIKit

class RidesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ridesTableView: UITableView!

    private var rides:[Ride] = [Ride]() {
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
        let cell = ridesTableView.dequeueReusableCell(withIdentifier: "RideCell", for: indexPath)
        cell.textLabel?.text = rides[indexPath.row].duration
        return cell
    }
    
    private var selectedRide: Ride?
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRide = rides[indexPath.row]
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
