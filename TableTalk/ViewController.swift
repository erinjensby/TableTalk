//
//  ViewController.swift
//  TestAuthorization
//
//  Created by Nicolas on 3/7/17.
//  Copyright © 2017 Nicolas Lavigne. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import MapKit
import CoreLocation
import FirebaseDatabase
import GooglePlaces

class ViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    var ref: FIRDatabaseReference!
    
    var places = [Place]()
    var placesClient: GMSPlacesClient!

    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var alertController:UIAlertController? = nil
    
    let locationManager = CLLocationManager()
    
    @IBAction func loginUser(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: emailField.text!, password: passField.text!, completion: { (user, error) in
            
            // Check that user isn't nil
            if let u = user {
                // User is found, go to home screen
                print("Logged in")
                print(u.email!)
                
                let vc:TabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyTabBar") as! TabBarController
                
                vc.places=self.places
                self.present(vc, animated: true, completion: nil)
            }
            else {
                // Error: check error and show message
                print("ERROR")
            }
        })
        loginButton.backgroundColor = UIColor.lightGray
    }
    
    @IBAction func createNewUser(_ sender: Any) {
        FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passField.text!, completion: { (user, error) in
            
            // Check that user isn't nil
            if let u = user {
                // User is found, go to home screen
                print(u.email!)
            }
            else {
                let message = "You must enter a valid email address and password."
                self.alertController = UIAlertController(title: "Warning", message: message, preferredStyle: UIAlertControllerStyle.alert)
                
                let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
                    print("Ok Button Pressed 1");
                }
                self.alertController!.addAction(OKAction)
                UIApplication.shared.keyWindow?.rootViewController?.present(self.alertController!, animated: true, completion:nil)
            }
        })
        
    }
    
    @IBAction func touchDown(_ sender: Any) {
        loginButton.backgroundColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        ref = FIRDatabase.database().reference()
        placesClient = GMSPlacesClient.shared()
        buildPlaceArray()

        print("after buildPlaceArray")
     
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        self.passField.delegate = self
        self.emailField.delegate = self
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func buildPlaceArray(){
        
        // Use only when updating firebase from locationIDs array
//        for placeID in StudyLocations.locationIDs {
//            let date = Date()
//            
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "MMM dd HH:mm:ss"
//            let timeStamp = dateFormatter.string(from: date)
//            
//            ref.child("Places").child(placeID).child(timeStamp).child("Num Tables").setValue(3)
//            ref.child("Places").child(placeID).child(timeStamp).child("Temperature").setValue(3)
//            ref.child("Places").child(placeID).child(timeStamp).child("Noise").setValue(3)
//        }
        
        ref.child("Places").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let dict = snapshot.value as? NSDictionary
            
            for (key,value) in dict! {
                let placeID = key as! String
                
                var noiseTotal = 0
                var numTablesTotal = 0
                var tempTotal = 0
                var count = 0
                for(_,value2) in (value as? NSDictionary)!{
                    count+=1
                    for(key3,value3) in (value2 as? NSDictionary)!{
                        if(key3 as? String == "Noise"){
                            noiseTotal+=value3 as! Int
                        }
                        if(key3 as? String  == "Num Tables"){
                            numTablesTotal+=value3 as! Int
                        }
                        if(key3 as? String == "Temperature"){
                            tempTotal+=value3 as! Int
                        }
                    }
                }

                var currentLocation:CLLocation?
                if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
                    CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
                    currentLocation = CLLocationManager().location
                }
                
                var distance: Double = 0
                self.placesClient!.lookUpPlaceID(placeID, callback: { (place, error) -> Void in
                    if let destination = place {
                        if let location = currentLocation {
                            
                            let currentCoordinates = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                            let destinationCoordinates = CLLocation(latitude: destination.coordinate.latitude, longitude: destination.coordinate.longitude)
                             distance = destinationCoordinates.distance(from: currentCoordinates)
                            
                             distance = distance / 1609.344
                            
                            var addr = destination.formattedAddress!
                            let range = addr.index(addr.endIndex, offsetBy: -5)..<addr.endIndex
                            addr.removeSubrange(range)
                            
                            self.postData(placeID: placeID, numTables: numTablesTotal/count, temp: tempTotal/count, noise: noiseTotal/count, dist: distance, placeName: destination.name, addr: addr, pObj: destination)
                        }
                    }
                })
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        })
    }
    
    func postData( placeID:String, numTables:Int, temp:Int, noise: Int, dist:Double, placeName:String, addr:String, pObj:GMSPlace){
        
        let tempPlace = Place(_placeID: placeID, _numTables: numTables, _temp: temp, _noise: noise, _dist: dist, _placeName: placeName, _addr: addr, _pObj: pObj)
        
        self.places.append(tempPlace)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

