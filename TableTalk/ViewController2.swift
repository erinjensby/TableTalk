//
//  ViewController.swift
//  tableTalkSurvey
//
//  Created by Erin Jensby on 3/7/17.
//  Copyright © 2017 Erin Jensby. All rights reserved.
//

import UIKit
import GooglePlaces
import FirebaseDatabase

class ViewController2: UIViewController {
    
    var placesClient: GMSPlacesClient!
    var ref: FIRDatabaseReference!
    var timer = Timer()
    var place: GMSPlace!

    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var numTablesLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var loudnessLbl: UILabel!
    
    @IBOutlet weak var numTablesSlider: UISlider!
    @IBOutlet weak var loudnessSlider: UISlider!
    @IBOutlet weak var tempSlider: UISlider!
   
    @IBOutlet weak var submitButton: UIButton!
    
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
    
    @IBAction func submitData(_ sender: Any) {
        submitButton.isUserInteractionEnabled = false
        submitButton.alpha = 0.6
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
        print("Please wait 5 seconds before submitting another response")
        let submitAlert = UIAlertController(title: "Response Submitted!", message: "Please wait 5 seconds before submitting another response.", preferredStyle: UIAlertControllerStyle.alert)
        submitAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(submitAlert, animated: true, completion: nil)

        let date = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd HH:mm:ss"
        let timeStamp = dateFormatter.string(from: date)
        print(locationLbl.text!)
        
        ref.child("Places").child(self.place.placeID).child(timeStamp).child("Num Tables").setValue(Int(numTablesSlider.value))
        ref.child("Places").child(self.place.placeID).child(timeStamp).child("Temperature").setValue(Int(tempSlider.value))
        ref.child("Places").child(self.place.placeID).child(timeStamp).child("Noise").setValue(Int(loudnessSlider.value))
        
    }
    
    func timerAction() {
        submitButton.isUserInteractionEnabled = true
        submitButton.alpha = 1
        print("You can now submit again")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        ref = FIRDatabase.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Code from Google Places API Guide
        placesClient = GMSPlacesClient.shared()
        
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            if let placeLikelihoodList = placeLikelihoodList {
                for likelihood in placeLikelihoodList.likelihoods {
                    self.place = likelihood.place
                   
                    print(self.place.name)
                    print(self.place.placeID)
                    for locationID in StudyLocations.locationIDs {
                        print(locationID)
                        if self.place.placeID == locationID {
                            self.locationLbl.text = self.place.name
                            break;
                        }
                    }
                }
            }
            self.locationLbl.adjustsFontSizeToFitWidth = true
        })
    }
}

