//
//  LocationDetails.swift
//  TableTalk
//
//  Created by Patrick Liu on 3/7/17.
//  Copyright © 2017 Patrick Liu. All rights reserved.
//

import UIKit

class LocationDetails: UIViewController {

    @IBOutlet weak var locNameLbl: UILabel!
    @IBOutlet weak var hrsLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var addrLbl: UILabel!
    @IBOutlet weak var websiteLbl: UILabel!
    @IBOutlet weak var dscrpLbl: UILabel!
    
    @IBOutlet weak var noiseLvl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var tableNum: UILabel!
    
    var names:[String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locNameLbl.text = names[0]
        hrsLbl.text = names[1]
        phoneLbl.text = names[2]
        addrLbl.text = names[3]
        websiteLbl.text = names[4]
        dscrpLbl.text = names[5]
        
        noiseLvl.text = names[6]
        tempLbl.text = names[7]
        tableNum.text = names[8]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
