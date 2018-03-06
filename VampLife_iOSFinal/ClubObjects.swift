//
//  ClubObjects.swift
//  VampLife_iOSFinal
//
//  Created by Brittany Darby on 2/24/18.
//  Copyright © 2018 Brittany Darby. All rights reserved.
//

import Foundation
import UIKit

class ClubObjects {
    
    var name: String
    var time: Bool
    var address: String
    var lat: Double
    var long: Double
    var photoReference: String
    
    init(name: String, time: Bool, address: String, lat: Double, long: Double, photoReference: String ){
        self.name = name
        self.time = time
        self.address = address
        self.lat = lat
        self.long = long
        self.photoReference = photoReference
    }
    
}

