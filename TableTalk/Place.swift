//
//  Place.swift
//  TableTalk
//
//  Created by Nicolas on 4/6/17.
//  Copyright © 2017 Nicolas Lavigne. All rights reserved.
//

import Foundation


class Place{
    
    public var placeID:String?
    public var numTables:Int?
    public var temp:Int?
    public var noise:Int?
    
    init(_placeID:String, _numTables:Int, _temp:Int, _noise:Int){
        placeID = _placeID
        numTables = _numTables
        temp = _temp
        noise = _noise
    }
    
    
    
}
