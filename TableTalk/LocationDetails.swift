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
    
    @IBOutlet weak var image: UIImageView!

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
    
//    var place:GMSPlace?
    var location:Place?
    
    var locName:String = "<location name>"
    var hrs:String = "24 / 7"
    var phone:String = "<phone>"
    var addr:String = "<address>"
    var website:String = "<website>"
    var dscrp:String = "No description available at this time."
    var noise:Int?
    var temp:Int?
    var table:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "TableTalk"
        if let location = self.location {
            let place = location.pObj!
            
            locName = place.name
            if var tempPhone = place.phoneNumber {
                tempPhone.remove(at: tempPhone.startIndex)
                tempPhone.remove(at: tempPhone.startIndex)
                tempPhone.remove(at: tempPhone.startIndex)
                phone = "("
                phone.append(tempPhone)
                let phoneRange = phone.index(phone.startIndex, offsetBy: 4)..<phone.index(phone.startIndex, offsetBy: 5)
                phone.replaceSubrange(phoneRange, with: ") ")
            }
            else {
                phone = "n/a"
            }
            addr = place.formattedAddress!
            if let web = place.website {
                website = web.absoluteString
            }
            else {
                website = "n/a"
            }
//            website = place.website!.absoluteString
            
            print("name: \(locName), phone: \(phone), addr: \(addr), website: \(website), open: \(place.openNowStatus.rawValue)")
            
            let range = addr.index(addr.endIndex, offsetBy: -5)..<addr.endIndex
            addr.removeSubrange(range)

            loadFirstPhotoForPlace(placeID: place.placeID)
            
            noise = location.noise!
            temp = location.temp!
            table = location.numTables!
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
//        noise = nameList[6]
//        temp = nameList[7]
//        table = nameList[8]
    }
    
    func changeTables() {
        let tableCount:Int = table!
        switch tableCount {
            case 0:
                tablesWhiteWidth.constant = 80
                tablesWhiteHeight.constant = 80
                tablesWhite.layer.cornerRadius = 40
                tableNum.text = "\(table!)"
                break
            case 1:
                tablesWhiteWidth.constant = 70
                tablesWhiteHeight.constant = 70
                tablesWhite.layer.cornerRadius = 35
                tableNum.text = "\(table!)"
                break
            case 2:
                tablesWhiteWidth.constant = 60
                tablesWhiteHeight.constant = 60
                tablesWhite.layer.cornerRadius = 30
                tableNum.text = "\(table!)"
                break
            case 3:
                tablesWhiteWidth.constant = 50
                tablesWhiteHeight.constant = 50
                tablesWhite.layer.cornerRadius = 25
                tableNum.text = "\(table!)"
                break
            case 4:
                tablesWhiteWidth.constant = 40
                tablesWhiteHeight.constant = 40
                tablesWhite.layer.cornerRadius = 20
                tableNum.text = "\(table!)"
                break
            case 5:
                tablesWhiteWidth.constant = 30
                tablesWhiteHeight.constant = 30
                tablesWhite.layer.cornerRadius = 15
                tableNum.text = "\(table!)"
                break
            case 6:
                tablesWhiteWidth.constant = 20
                tablesWhiteHeight.constant = 20
                tablesWhite.layer.cornerRadius = 10
                tableNum.text = "\(table!)"
                break
            case 7:
                tablesWhiteWidth.constant = 10
                tablesWhiteHeight.constant = 10
                tablesWhite.layer.cornerRadius = 5
                tableNum.text = "\(table!)"
                break
            default:
                tablesWhiteWidth.constant = 0
                tablesWhiteHeight.constant = 0
                tableNum.text = "8+"
        }
    }
    
    func changeTemp() {
        let temp:Int = self.temp!
        switch temp {
        case 0:
            tempWhiteWidth.constant = 80
            tempWhiteHeight.constant = 80
            tempWhite.layer.cornerRadius = 40
            tempLvl.text = "cold"
            break
        case 1:
            tempWhiteWidth.constant = 60
            tempWhiteHeight.constant = 60
            tempWhite.layer.cornerRadius = 30
            tempLvl.text = "cool"
            break
        case 2:
            tempWhiteWidth.constant = 40
            tempWhiteHeight.constant = 40
            tempWhite.layer.cornerRadius = 20
            tempLvl.text = "average"
            break
        case 3:
            tempWhiteWidth.constant = 20
            tempWhiteHeight.constant = 20
            tempWhite.layer.cornerRadius = 10
            tempLvl.text = "warm"
            break
        default:
            tempWhiteWidth.constant = 0
            tempWhiteHeight.constant = 0
            tempLvl.text = "hot"
        }
    }
    
    func changeNoise() {
        let noise:Int = self.noise!
        switch noise {
        case 0:
            noiseWhiteWidth.constant = 80
            noiseWhiteHeight.constant = 80
            noiseWhite.layer.cornerRadius = 40
            noiseLvl.text = "silent"
            break
        case 1:
            noiseWhiteWidth.constant = 53
            noiseWhiteHeight.constant = 53
            noiseWhite.layer.cornerRadius = 26.5
            noiseLvl.text = "quiet"
            break
        case 2:
            noiseWhiteWidth.constant = 27
            noiseWhiteHeight.constant = 27
            noiseWhite.layer.cornerRadius = 13.5
            noiseLvl.text = "average"
            break
        default:
            noiseWhiteWidth.constant = 0
            noiseWhiteHeight.constant = 0
            noiseLvl.text = "loud"
        }
    }
    
    func loadFirstPhotoForPlace(placeID: String) {
        GMSPlacesClient.shared().lookUpPhotos(forPlaceID: placeID) { (photos, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                if let firstPhoto = photos?.results.first {
                    self.loadImageForMetadata(photoMetadata: firstPhoto)
                }
            }
        }
    }
    
    func loadImageForMetadata(photoMetadata: GMSPlacePhotoMetadata) {
        GMSPlacesClient.shared().loadPlacePhoto(photoMetadata, callback: {
            (photo, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                self.image.image = photo
            }
        })
    }
}
