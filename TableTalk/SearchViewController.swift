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
    var locations:[GMSPlace] = [GMSPlace]()
//    var locations:Dictionary<String, GMSPlace> = Dictionary<String, GMSPlace>()
//    var locations:Dictionary<String, String> = Dictionary<String, String>()
//    var locations:[String]
    var allLocations:[String] = ["Epoch Coffee", "E"]
    var searchLocations:[GMSPlace] = [GMSPlace]()
//    var searchedLocations:
    var placesClient: GMSPlacesClient!
    @IBOutlet weak var searchTableView: UITableView!
    
    func createLocationDictionary() {
        for locationID in StudyLocations.locationIDs {
            placesClient.lookUpPlaceID(locationID, callback: { (place, error) -> Void in
                if let error = error {
                    print("lookup place id query error: \(error.localizedDescription)")
                    return
                }
                
                guard let place = place else {
                    print("No place details for \(locationID)")
                    return
                }
                
                self.locations.append(place)
                                print("Place name \(place.name)")
                                print("Place address \(String(describing: place.formattedAddress))")
                                print("Place placeID \(place.placeID)")
            })
        }
    }
    
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
        
        createLocationDictionary()
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
                destinationVC.place = loc

                var names:[String] = [String]()
                names.append("Epoch Coffee")
                names.append("24 / 7")
                names.append("(512) 454-3762")
                names.append("221 W N Loop Blvd Austin, TX 78751")
                names.append("epochcoffee.com")
                names.append("24/7 coffee shop vending espresso drinks, sweets & pizza from East Side Pies in open, casual space.")
                names.append("2")
                names.append("3")
                names.append("8")
                destinationVC.setNames(nameList: names)
                
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
        searchLocations = locations.filter {(location) in
            let locationName = location.name
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
        
        let location:GMSPlace = searchLocations[indexPath.row]
        cell?.locationLabel?.text = location.name
        var addr = location.formattedAddress!
        let range = addr.index(addr.endIndex, offsetBy: -5)..<addr.endIndex
        addr.removeSubrange(range)
        cell?.addrLabel?.text = addr
        let distance = calculateDistance(destination: location)
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
        let alpha:CGFloat =
            (CGFloat(numRows - rowNumber)) * 0.8 / (CGFloat(numRows))
        cell?.backgroundColor = currentColor?.withAlphaComponent(CGFloat(alpha))
    }
    
    func calculateDistance(destination: GMSPlace) -> Double {
        var currentLocation:CLLocation?
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            
            currentLocation = CLLocationManager().location
            
        }
//        var currentLocation:GMSPlace? = nil
//        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
//            if let error = error {
//                print("Pick Place error: \(error.localizedDescription)")
//                return
//            }
//            
//            if let placeLikelihoodList = placeLikelihoodList {
//                var probability = placeLikelihoodList.likelihoods[0].likelihood
//                currentLocation = placeLikelihoodList.likelihoods[0].place
//                for likelihood in placeLikelihoodList.likelihoods {
//                    if probability < likelihood.likelihood {
//                        probability = likelihood.likelihood
//                        currentLocation = likelihood.place
//                    }
//                }
//            }
//        })
//        while currentLocation == nil {
//            wait()
//        }
        if let location = currentLocation {
            let currentCoordinates = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let destinationCoordinates = CLLocation(latitude: destination.coordinate.latitude, longitude: destination.coordinate.longitude)
            let distance = destinationCoordinates.distance(from: currentCoordinates)
            return distance / 1609.344
        }
        return -1
    }
    
//    func wait() {
//        RunLoop.current.run(mode: RunLoopMode.defaultRunLoopMode, before: NSDate(timeIntervalSinceNow: 1) as Date)
//    }
}
