//
//  LocationDetails.swift
//  TableTalk
//
//  Created by Patrick Liu on 3/7/17.
//  Copyright © 2017 Patrick Liu. All rights reserved.
//

import UIKit
import GooglePlaces

class LocationDetails: UIViewController {

    @IBOutlet weak var locNameLbl: UILabel!
    @IBOutlet weak var hrsLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var addrLbl: UILabel!
    @IBOutlet weak var websiteLbl: UILabel!
    @IBOutlet weak var dscrpLbl: UILabel!
    
    @IBOutlet weak var noiseLvl: UILabel!
    @IBOutlet weak var tempLvl: UILabel!
    @IBOutlet weak var tableNum: UILabel!
    
    @IBOutlet weak var noiseWhite: UILabel!
    @IBOutlet weak var noiseWhiteWidth: NSLayoutConstraint!
    @IBOutlet weak var noiseWhiteHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tempWhite: UILabel!
    @IBOutlet weak var tempWhiteWidth: NSLayoutConstraint!
    @IBOutlet weak var tempWhiteHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tablesWhite: UILabel!
    @IBOutlet weak var tablesWhiteWidth: NSLayoutConstraint!
    @IBOutlet weak var tablesWhiteHeight: NSLayoutConstraint!
    
    var place:GMSPlace?
    
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
        self.title = "TableTalk"
        if let place = self.place {
            locName = place.name
            var tempPhone = place.phoneNumber!
            addr = place.formattedAddress!
            website = place.website!.absoluteString
        
            print("name: \(locName), phone: \(tempPhone), addr: \(addr), website: \(website), open: \(place.openNowStatus.rawValue)")
            
            tempPhone.remove(at: tempPhone.startIndex)
            tempPhone.remove(at: tempPhone.startIndex)
            tempPhone.remove(at: tempPhone.startIndex)
            phone = "("
            phone.append(tempPhone)
            let phoneRange = phone.index(phone.startIndex, offsetBy: 4)..<phone.index(phone.startIndex, offsetBy: 5)
            phone.replaceSubrange(phoneRange, with: ") ")
            let range = addr.index(addr.endIndex, offsetBy: -5)..<addr.endIndex
            addr.removeSubrange(range)
        }
        
        locNameLbl.text = locName
        hrsLbl.text = hrs
        phoneLbl.text = phone
        addrLbl.text = addr
        websiteLbl.text = website
        dscrpLbl.text = dscrp
        
        changeTables()
        changeTemp()
        changeNoise()
        
        self.locNameLbl.adjustsFontSizeToFitWidth = true
        self.hrsLbl.adjustsFontSizeToFitWidth = true
        self.phoneLbl.adjustsFontSizeToFitWidth = true
        self.addrLbl.adjustsFontSizeToFitWidth = true
        self.websiteLbl.adjustsFontSizeToFitWidth = true
        self.dscrpLbl.adjustsFontSizeToFitWidth = true
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
    
    func changeTables() {
        let tableCount:Int = Int(table)!
        tableNum.text = table
        switch tableCount {
            case 0:
                tablesWhiteWidth.constant = 80
                tablesWhiteHeight.constant = 80
                tablesWhite.layer.cornerRadius = 40
                break
            case 1:
                tablesWhiteWidth.constant = 70
                tablesWhiteHeight.constant = 70
                tablesWhite.layer.cornerRadius = 35
                break
            case 2:
                tablesWhiteWidth.constant = 60
                tablesWhiteHeight.constant = 60
                tablesWhite.layer.cornerRadius = 30
                break
            case 3:
                tablesWhiteWidth.constant = 50
                tablesWhiteHeight.constant = 50
                tablesWhite.layer.cornerRadius = 25
                break
            case 4:
                tablesWhiteWidth.constant = 40
                tablesWhiteHeight.constant = 40
                tablesWhite.layer.cornerRadius = 20
                break
            case 5:
                tablesWhiteWidth.constant = 30
                tablesWhiteHeight.constant = 30
                tablesWhite.layer.cornerRadius = 15
                break
            case 6:
                tablesWhiteWidth.constant = 20
                tablesWhiteHeight.constant = 20
                tablesWhite.layer.cornerRadius = 10
                break
            case 7:
                tablesWhiteWidth.constant = 10
                tablesWhiteHeight.constant = 10
                tablesWhite.layer.cornerRadius = 5
                break
            default:
                tablesWhiteWidth.constant = 0
                tablesWhiteHeight.constant = 0
        }
    }
    
    func changeTemp() {
        let tableCount:Int = Int(table)!
        switch tableCount {
        case 0:
            tablesWhiteWidth.constant = 80
            tablesWhiteHeight.constant = 80
            tablesWhite.layer.cornerRadius = 40
            tempLvl.text = "cold"
            break
        case 1:
            tablesWhiteWidth.constant = 60
            tablesWhiteHeight.constant = 60
            tablesWhite.layer.cornerRadius = 30
            tempLvl.text = "cool"
            break
        case 2:
            tablesWhiteWidth.constant = 40
            tablesWhiteHeight.constant = 40
            tablesWhite.layer.cornerRadius = 20
            tempLvl.text = "average"
            break
        case 3:
            tablesWhiteWidth.constant = 20
            tablesWhiteHeight.constant = 20
            tablesWhite.layer.cornerRadius = 10
            tempLvl.text = "warm"
            break
        default:
            tablesWhiteWidth.constant = 0
            tablesWhiteHeight.constant = 0
            tempLvl.text = "hot"
        }
    }
    
    func changeNoise() {
        let tableCount:Int = Int(table)!
        switch tableCount {
        case 0:
            tablesWhiteWidth.constant = 80
            tablesWhiteHeight.constant = 80
            tablesWhite.layer.cornerRadius = 40
            noiseLvl.text = "silent"
            break
        case 1:
            tablesWhiteWidth.constant = 53
            tablesWhiteHeight.constant = 53
            tablesWhite.layer.cornerRadius = 26.5
            noiseLvl.text = "quiet"
            break
        case 2:
            tablesWhiteWidth.constant = 27
            tablesWhiteHeight.constant = 27
            tablesWhite.layer.cornerRadius = 13.5
            noiseLvl.text = "average"
            break
        default:
            tablesWhiteWidth.constant = 0
            tablesWhiteHeight.constant = 0
            noiseLvl.text = "loud"
        }
    }
}
