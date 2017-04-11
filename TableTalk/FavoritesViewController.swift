//
//  FavoritesViewController.swift
//  TableTalk
//
//  Created by Nicolas on 4/9/17.
//  Copyright © 2017 Nicolas Lavigne. All rights reserved.
//

import UIKit
import Firebase

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favTable.delegate = self
        favTable.dataSource = self
        
        print(FIRAuth.auth()?.currentUser?.uid)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
        
         func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
        
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return 8
        }
        
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "locationID", for: indexPath)
          
            
            
            return cell
        }

        
        
    }

