//
//  Place.swift
//  TableTalk
//
//  Created by Nicolas on 4/6/17.
//  Copyright © 2017 Nicolas Lavigne. All rights reserved.
//

import Foundation


class Place{
    
    public var name:String?
    public var numTables:Int?
    public var temp:Int?
    public var noise:Int?
    
    init(_name:String, _numTables:Int, _temp:Int, _noise:Int){
        name = _name
        numTables = _numTables
        temp = _temp
        noise = _noise
    }
    
    
    
}
