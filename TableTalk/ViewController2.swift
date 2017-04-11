//
//  ViewController.swift
//  tableTalkSurvey
//
//  Created by Erin Jensby on 3/7/17.
//  Copyright © 2017 Erin Jensby. All rights reserved.
//

import UIKit
import GooglePlaces

class ViewController2: UIViewController {
    
    var placesClient: GMSPlacesClient!

    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var numTablesLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var loudnessLbl: UILabel!
    
    @IBOutlet weak var numTablesSlider: UISlider!
    @IBOutlet weak var tempSlider: UISlider!
    @IBOutlet weak var loudnessSlider: UISlider!
    
    @IBAction func tableSliderValueChanged(_ sender: UISlider) {
        let currentValue:Int = Int(sender.value)
        if (currentValue == 8 || currentValue == 9) {
            numTablesLbl.text = "8+"
        }
        else {
            numTablesLbl.text = "\(currentValue)"
        }
    }
    
    @IBAction func tempSliderValueChanged(_ sender: UISlider) {
        let currentValue:Int = Int(sender.value)
        switch currentValue {
        case 0:
            tempLbl.text = "cold"
        case 1:
            tempLbl.text = "cool"
        case 2:
            tempLbl.text = "average"
        case 3:
            tempLbl.text = "warm"
        case 4:
            tempLbl.text = "hot"
        case 5:
            tempLbl.text = "hot"
        default:
            tempLbl.text = "average"
        }
    }
    
    @IBAction func loundnessSliderValueChanged(_ sender: UISlider) {
        let currentValue:Int = Int(sender.value)
        switch currentValue {
        case 0:
            loudnessLbl.text = "silent"
        case 1:
            loudnessLbl.text = "quiet"
        case 2:
            loudnessLbl.text = "average"
        case 3:
            loudnessLbl.text = "loud"
        case 4:
            loudnessLbl.text = "loud"
        default:
            loudnessLbl.text = "average"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Code from Google Places API Guide
        placesClient = GMSPlacesClient.shared()
        
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            if let placeLikelihoodList = placeLikelihoodList {
                for likelihood in placeLikelihoodList.likelihoods {
                    let place = likelihood.place
                    print(place.name)
                    print(place.placeID)
                    for locationID in StudyLocations.locationIDs {
                        print(locationID)
                        if place.placeID == locationID {
                            self.locationLbl.text = place.name
                            break;
                        }
                    }
                }
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

