//
//  LocationListViewController.swift
//  TableTalk
//
//  Created by Patrick Liu on 4/1/17.
//  Copyright © 2017 Nicolas Lavigne. All rights reserved.
//

import UIKit
import GooglePlaces

class LocationListViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var listCategory: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    var placesClient: GMSPlacesClient!
    var places = [Place]()
    
    var categoryList:[String] = [String]()
    
    func initCategoryList() {
        categoryList = ["Distance", "Noise", "Temperature", "Open Tables"]
    }
    
    @IBAction func selectCategory(_ sender: Any) {
        categoryPicker.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initCategoryList()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.listCategory.delegate = self
        self.categoryPicker.delegate = self
        self.categoryPicker.dataSource = self
        self.categoryPicker.isHidden = true
        self.listCategory.text = "Distance"
        places.sort { $0.dist! < $1.dist! }
        
        placesClient = GMSPlacesClient.shared()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
    
        backItem.tintColor = UIColor.white
        navigationItem.backBarButtonItem = backItem
        
        if segue.identifier == "locDesc" {
            if let destinationVC = segue.destination as? LocationDetails {
                let row = (self.tableView.indexPathForSelectedRow?.row)!
                let loc = self.places[row]
                destinationVC.location = loc
                
                let backButton = UIBarButtonItem()
                backButton.title = "List"
                navigationItem.backBarButtonItem = backButton
            }
        }
    }
}

extension LocationListViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return self.categoryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return self.categoryList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.listCategory.text = self.categoryList[row]
        self.categoryPicker.isHidden = true
        
        if(self.listCategory.text == "Distance"){
            places.sort { $0.dist! < $1.dist! }
        }
        if(self.listCategory.text == "Temperature"){
            places.sort { $0.temp! < $1.temp! }
        }
        if(self.listCategory.text == "Open Tables"){
            places.sort { $0.numTables! > $1.numTables! }
        }
        if(self.listCategory.text == "Noise"){
            places.sort { $0.noise! < $1.noise! }
        }
        self.tableView.reloadData()
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var attributedString: NSAttributedString!
        attributedString = NSAttributedString(string: categoryList[row], attributes: [NSForegroundColorAttributeName : UIColor.darkGray])
        return attributedString
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.listCategory {
            self.categoryPicker.isHidden = false
            textField.endEditing(true)
        }
    }
}

extension LocationListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationID", for: indexPath) as? LocationCell
        
        cell?.backgroundColor = UIColor(hex: 0x8888d7)
        
        // Configure the cell...
        
        let placeID = places[indexPath.row].placeID
        let name = places[indexPath.row].placeName
        let dist = places[indexPath.row].dist
        let roundDist = Double(round(10*dist!)/10)
        let addr = places[indexPath.row].address
        
        cell?.locationLabel.text = name
        cell?.distLabel.text = "\(roundDist) mi"
        cell?.addrLabel.text = addr
        
        setColor(rowNumber: indexPath.row, cell: cell, numRows: places.count)
        
        return cell!
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
