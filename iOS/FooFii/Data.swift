//
//  Data.swift
//  FooFii
//
//  Created by Calvin Rose on 3/20/18.
//  Copyright © 2018 Calvin Rose. All rights reserved.
//

import Foundation
import Firebase
import GeoFire

let ref = Database.database().reference()
let gfMarkets = GeoFire(firebaseRef: ref.child("markets/geofire"))
let gfSnap = GeoFire(firebaseRef: ref.child("snap/geofire"))

