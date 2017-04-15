//
//  LocationCell.swift
//  TableTalk
//
//  Created by Patrick Liu on 3/6/17.
//  Copyright © 2017 Patrick Liu. All rights reserved.
//

import UIKit
import GooglePlaces

class LocationCell: UITableViewCell {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var addrLabel: UILabel!
    @IBOutlet weak var distLabel: UILabel!
    
    var locationText:String = ""
    var addrText:String = ""
    var distText:String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyle.none
//        locationLabel?.text = locationText
//        addrLabel?.text = addrText
//        distLabel?.text = distText
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
