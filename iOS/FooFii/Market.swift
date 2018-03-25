//
//  Market.swift
//  FooFii
//
//  Created by Calvin Rose on 3/25/18.
//  Copyright © 2018 Calvin Rose. All rights reserved.
//

import Foundation

class Market {
    
    let name: String
    let address: String
    let cityName: String
    let state: String
    let facebook: String
    let tags: [String]
    let zip: String
    let website: String
    let latlong: (Double, Double)
    
    init(name: String,
         address: String,
         cityName: String,
         state: String,
         zip: String,
         tags: [String],
         facebook: String,
         website: String,
         latlong: (Double, Double)) {
        self.name = name;
        self.address = address;
        self.cityName = cityName;
        self.state = state;
        self.zip = zip;
        self.facebook = facebook;
        self.tags = tags;
        self.website = website;
        self.latlong = latlong;
    }
    
}

extension Market: CustomStringConvertible {
    var description: String {
        return "(\(name), \(address))"
    }
}
