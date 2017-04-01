//
//  ListView.swift
//  TableTalk
//
//  Created by Patrick Liu on 3/6/17.
//  Copyright © 2017 Patrick Liu. All rights reserved.
//

import UIKit

class ListView: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 9
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationID", for: indexPath) as? LocationCell
        
        cell?.backgroundColor = UIColor(hex: 0x8888d7)

        // Configure the cell...
        if indexPath.row == 0 {
            cell?.locationLabel.text = "Epoch Coffee"
            cell?.addrLabel.text = "221 W North Loop Blvd, Austin"
            cell?.distLabel.text = "1.2 mi"
        }
        
        setColor(rowNumber: indexPath.row, cell: cell, numRows: 9)

        return cell!
    }

       
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "locDesc" {
            
            if let destinationVC = segue.destination as? LocationDetails {
                destinationVC.names.append("Epoch Coffee")
                destinationVC.names.append("24 / 7")
                destinationVC.names.append("(512) 454-3762")
                destinationVC.names.append("221 W N Loop Blvd Austin, TX 78751")
                destinationVC.names.append("epochcoffee.com")
                destinationVC.names.append("24/7 coffee shop vending espresso drinks, sweets & pizza from East Side Pies in open, casual space.")
                
                destinationVC.names.append("3.6")
                destinationVC.names.append("7.4")
                destinationVC.names.append("5.8")
            }
        }

    }
    
    func setColor(rowNumber: Int, cell: LocationCell?, numRows: Int) {
        let currentColor = cell?.backgroundColor
        let alpha:CGFloat =
            (CGFloat(numRows - rowNumber)) * 0.8 / (CGFloat(numRows))
        cell?.backgroundColor = currentColor?.withAlphaComponent(CGFloat(alpha))
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex:Int) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
}
