//
//  Place.swift
//  TableTalk
//
//  Created by Nicolas on 4/6/17.
//  Copyright © 2017 Nicolas Lavigne. All rights reserved.
//

import Foundation
import GooglePlaces

class Place{
    
    public var placeID:String?
    public var numTables:Int?
    public var temp:Int?
    public var noise:Int?
    public var dist:Double?
    public var placeName:String?
    public var address:String?
    public var pObj:GMSPlace?
    
    init(_placeID:String, _numTables:Int, _temp:Int, _noise:Int, _dist:Double, _placeName:String, _addr:String, _pObj:GMSPlace){
        placeID = _placeID
        numTables = _numTables
        temp = _temp
        noise = _noise
        dist = _dist
        placeName = _placeName
        address = _addr
        pObj = _pObj
    }
    
    
    
}
