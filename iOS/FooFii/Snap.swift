//
//  Snap.swift
//  FooFii
//
//  Created by Calvin Rose on 3/25/18.
//  Copyright © 2018 Calvin Rose. All rights reserved.
//

import Foundation

class Snap {
    
    let name: String
    let address: String
    let cityName: String
    let state: String
    let zip: String
    let latlong: (Double, Double)
    
    init(name: String,
         address: String,
         cityName: String,
         state: String,
         zip: String,
         latlong: (Double, Double)) {
        self.name = name;
        self.address = address;
        self.cityName = cityName;
        self.state = state;
        self.zip = zip;
        self.latlong = latlong;
    }
    
}

extension Snap: CustomStringConvertible {
    var description: String {
        return "(\(name), \(address))"
    }
}
