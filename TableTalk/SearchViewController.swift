//
//  SearchViewController.swift
//  TableTalk
//
//  Created by Patrick Liu on 4/6/17.
//  Copyright © 2017 Nicolas Lavigne. All rights reserved.
//

import UIKit
import GooglePlaces

class SearchViewController: UIViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    var places: [Place] = [Place]()
    var locations: [GMSPlace] = [GMSPlace]()
    var searchLocations: [Place] = [Place]()
    var placesClient: GMSPlacesClient!
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.barTintColor = UIColor(hex:0x8888d7)
        searchController.searchBar.sizeToFit()
        searchController.searchBar.isTranslucent = true
        
        searchTableView.tableHeaderView = searchController.searchBar
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        placesClient = GMSPlacesClient.shared()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "locDesc" {
            if let destinationVC = segue.destination as? LocationDetails {
                let row = (self.searchTableView.indexPathForSelectedRow?.row)!
                let loc = self.searchLocations[row]
                destinationVC.location = loc
                
                self.searchController.searchBar.endEditing(true)
                let backButton = UIBarButtonItem()
                backButton.title = "Search"
                navigationItem.backBarButtonItem = backButton
                
                searchController.isActive = false
            }
        }
    }
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        searchForResult(search: searchController.searchBar.text!)
    }
    
    func searchForResult(search: String, scope: String = "All") {
        searchLocations = places.filter {(location) in
            let locationName = location.placeName!
            if locationName.lowercased().range(of: search.lowercased()) != nil {
                return true
            }
            return false
        }
        searchTableView.reloadData()
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationID", for: indexPath) as? LocationCell
        
        cell?.backgroundColor = UIColor(hex: 0x8888d7)
        
        let location: Place = searchLocations[indexPath.row]
        let gmsLocation: GMSPlace = location.pObj!
        cell?.locationLabel?.text = gmsLocation.name
        var addr = gmsLocation.formattedAddress!
        let range = addr.index(addr.endIndex, offsetBy: -5)..<addr.endIndex
        addr.removeSubrange(range)
        cell?.addrLabel?.text = addr
        let distance = calculateDistance(destination: gmsLocation)
        if distance >= 0 {
            cell?.distLabel?.text = "\(Double(round(10*distance)/10)) mi"
        }
        else {
            cell?.distLabel?.text = "n/a"
        }
        
        setColor(rowNumber: indexPath.row, cell: cell, numRows: searchLocations.count)
        return cell!
    }
    
    func setColor(rowNumber: Int, cell: LocationCell?, numRows: Int) {
        let currentColor = cell?.backgroundColor
        let alpha: CGFloat =
            (CGFloat(numRows - rowNumber)) * 0.8 / (CGFloat(numRows))
        cell?.backgroundColor = currentColor?.withAlphaComponent(CGFloat(alpha))
    }
    
    func calculateDistance(destination: GMSPlace) -> Double {
        var currentLocation:CLLocation?
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            
            currentLocation = CLLocationManager().location
            
        }
        if let location = currentLocation {
            let currentCoordinates = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let destinationCoordinates = CLLocation(latitude: destination.coordinate.latitude, longitude: destination.coordinate.longitude)
            let distance = destinationCoordinates.distance(from: currentCoordinates)
            return distance / 1609.344
        }
        return -1
    }
}
