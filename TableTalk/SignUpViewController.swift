//
//  SignUpViewController.swift
//  TableTalk
//
//  Created by Patrick Liu on 4/23/17.
//  Copyright © 2017 Nicolas Lavigne. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var confPassField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    var places = [Place]()
    
    var ref: FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        ref = FIRDatabase.database().reference()
        
        emailField.delegate = self
        passField.delegate = self
        confPassField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUp(_ sender: Any) {
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        if (emailField.text?.isEmpty)! || (passField.text?.isEmpty)! || (confPassField.text?.isEmpty)!{
            let message = "Please fill in all fields."
            let emptyAlert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
            emptyAlert.addAction(OKAction)
            present(emptyAlert, animated: true, completion: nil)
            return
        }
        if passField.text! != confPassField.text! {
            let message = "Passwords do not match."
            let incorrectPasswordAlert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
            incorrectPasswordAlert.addAction(OKAction)
            present(incorrectPasswordAlert, animated: true, completion: nil)
            return
        }
        FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passField.text!, completion: { (user, error) in
            
            // Check that user isn't nil
            if let u = user {
                // User is found, go to home screen
                print(u.email!)
                let message = "Account created."
                let createUserAlert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
                let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    (action: UIAlertAction) in
                    FIRAuth.auth()?.signIn(withEmail: self.emailField.text!, password: self.passField.text!, completion: { (user, error) in
                        
                        // Check that user isn't nil
                        if let u = user {
                            // User is found, go to home screen
                            print("Logged in")
                            print(u.email!)
                            
                            let vc:TabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyTabBar") as! TabBarController
                            
                            vc.places = self.places
                            self.present(vc, animated: true, completion: nil)
                        }
                        else {
                            // Error: check error and show message
                            let error = UIAlertController(title: "", message: "Incorrect username or password", preferredStyle: UIAlertControllerStyle.alert)
                            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                            error.addAction(OKAction)
                            self.present(error, animated: true, completion: nil)
                            print("ERROR")
                        }
                    })
                    self.signupButton.backgroundColor = UIColor.lightGray
                    
                }
                createUserAlert.addAction(OKAction)
                self.present(createUserAlert, animated: true, completion: nil)
            }
            else {
                let message = "You must enter a valid email address and password."
                let createUserAlert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
                let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                createUserAlert.addAction(OKAction)
                self.present(createUserAlert, animated: true, completion: nil)
            }
        })
    }
    
    @IBAction func logIn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
