//
//  ClubObjects.swift
//  VampLife_iOSFinal
//
//  Created by Brittany Darby on 2/24/18.
//  Copyright © 2018 Brittany Darby. All rights reserved.
//

import Foundation
import UIKit

class ClubClass {
    
    var name: String
    var time: String
    var price: String
    var address: String
    var lat: String
    var long: String
    
    init(name: String, time: String, price: String, address: String, lat: String, long: String){
        self.name = name
        self.time = time
        self.price = price
        self.address = address
        self.lat = lat
        self.long = long
    }
    
}

