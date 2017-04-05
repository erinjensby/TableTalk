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
    
    var locName:String = "<location name>"
    var hrs:String = "<hours>"
    var phone:String = "<phone>"
    var addr:String = "<address>"
    var website:String = "<website>"
    var dscrp:String = "<description>"
    var noise:String = "average"
    var temp:String = "average"
    var table:String = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locNameLbl.text = locName
        hrsLbl.text = hrs
        phoneLbl.text = phone
        addrLbl.text = addr
        websiteLbl.text = website
        dscrpLbl.text = dscrp
        
        noiseLvl.text = noise
        tempLbl.text = temp
        tableNum.text = table
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNames(nameList:[String]) {
        locName = nameList[0]
        hrs = nameList[1]
        phone = nameList[2]
        addr = nameList[3]
        website = nameList[4]
        dscrp = nameList[5]
        noise = nameList[6]
        temp = nameList[7]
        table = nameList[8]
    }
}
