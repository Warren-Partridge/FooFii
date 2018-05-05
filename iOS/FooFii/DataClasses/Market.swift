//
//  Market.swift
//  FooFii
//
//  Copyright © 2018 Global App Initiative. All rights reserved.
//

import Foundation
import CoreLocation

// Represent 1 Farmer's Market
class Market: FoodLocation {
    
    let name: String
    let address: String
    let cityName: String
    let state: String
    let facebook: String
    let tags: [String]
    let zip: String
    let website: String
    let latlong: CLLocation
    
    init(uid: String,
         name: String,
         address: String,
         cityName: String,
         state: String,
         zip: String,
         tags: [String],
         facebook: String,
         website: String,
         latlong: CLLocation) {
        
        self.name = name
        self.address = address
        self.cityName = cityName
        self.state = state
        self.zip = zip
        self.facebook = facebook
        self.tags = tags
        self.website = website
        self.latlong = latlong
        
        super.init(uid: uid)
    }
    
}

extension Market: CustomStringConvertible {
    var description: String {
        return "<Market \(uid)>(\(name))"
    }
}
