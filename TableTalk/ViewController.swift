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

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var ref: FIRDatabaseReference!
    
    var places = [Place]()
    

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
        
        buildPlaceArray()
        
        print("after method")
     
        
       UIApplication.shared.isNetworkActivityIndicatorVisible = true
       
        
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func buildPlaceArray(){
        
        
        
        ref.child("Places").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let dict = snapshot.value as? NSDictionary
            
            for (key,value) in dict! {
                var placeID = key as! String
                
                var noiseTotal = 0
                var numTablesTotal = 0
                var tempTotal = 0
                var count = 0
                for(key2,value2) in (value as? NSDictionary)!{
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
                
             
                //create place here
                let tempPlace = Place(_placeID: placeID, _numTables: numTablesTotal/count, _temp: tempTotal/count, _noise: noiseTotal/count)
                
                
                
                self.places.append(tempPlace)
               print("In the method")

                
                
                
                
                
            }
            
            // ...
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.postData()

        })
    
    }
    
    func postData(){
        print("TEST \(places.count)")
      
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

