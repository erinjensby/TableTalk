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
    var allLocations:[String] = ["Epoch Coffee", "E"]
    var searchLocations:[String] = [String]()
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
                searchController.isActive = false
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
            }
        }
    }
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        searchForResult(search: searchController.searchBar.text!)
    }
    
    func searchForResult(search: String, scope: String = "All") {
        searchLocations = allLocations.filter {(location) in
            if location.lowercased().range(of: search.lowercased()) != nil {
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
        cell?.locationLabel?.text = searchLocations[indexPath.row]
        setColor(rowNumber: indexPath.row, cell: cell, numRows: searchLocations.count)
        return cell!
    }
    
    func setColor(rowNumber: Int, cell: LocationCell?, numRows: Int) {
        let currentColor = cell?.backgroundColor
        let alpha:CGFloat =
            (CGFloat(numRows - rowNumber)) * 0.8 / (CGFloat(numRows))
        cell?.backgroundColor = currentColor?.withAlphaComponent(CGFloat(alpha))
    }
}
