//
//  Snap.swift
//  FooFii
//
//  Copyright © 2018 Global App Initiative. All rights reserved.
//

import Foundation
import CoreLocation

// Represent 1 SNAP provider (grocery store, etc.)
class Snap: FoodLocation {
    
    let name: String
    let address: String
    let cityName: String
    let state: String
    let zip: String
    let latlong: CLLocation
    
    init(uid: String,
         name: String,
         address: String,
         cityName: String,
         state: String,
         zip: String,
         latlong: CLLocation) {
        
        self.name = name;
        self.address = address;
        self.cityName = cityName;
        self.state = state;
        self.zip = zip;
        self.latlong = latlong;
        
        super.init(uid: uid)
    }
    
}

extension Snap: CustomStringConvertible {
    var description: String {
        return "<Snap \(uid)>(\(name), \(address))"
    }
}
