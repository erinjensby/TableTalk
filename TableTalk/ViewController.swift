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

class ViewController: UIViewController, CLLocationManagerDelegate {
    
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
       
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

