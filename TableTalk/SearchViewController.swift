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
    
    let searchControllerTest = UISearchController(searchResultsController: nil)
    var allLocations:[String] = ["Epoch Coffee", "E"]
    var searchLocations:[String] = [String]()
//    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchControllerTest.searchResultsUpdater = self
        searchControllerTest.dimsBackgroundDuringPresentation = false
        searchControllerTest.hidesNavigationBarDuringPresentation = false
        searchControllerTest.searchBar.barTintColor = UIColor(hex:0x8888d7)
        searchControllerTest.searchBar.sizeToFit()
        searchControllerTest.searchBar.isTranslucent = true
        
        searchTableView.tableHeaderView = searchControllerTest.searchBar
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
