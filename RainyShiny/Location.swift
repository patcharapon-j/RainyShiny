//
//  Location.swift
//  RainyShiny
//
//  Created by Patcharapon Joksamut on 1/31/2560 BE.
//  Copyright © 2560 Patcharapon Joksamut. All rights reserved.
//

import Foundation
import CoreLocation

class Location{
    
    static var sharedInstance = Location()
    private init() {}
    
    var latitude = 0.0
    var longitude = 0.0
    
}
