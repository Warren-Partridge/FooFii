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

// For markets
//let gfMarkets = GeoFire(firebaseRef: ref.child("markets/geofire"))

// Given a coordinate and radius, get all snap providers in an area.
// The query is async, so you must pass in two callbacks for
// either an Array of Snap items, or a string describing the error.
func querySnap(lat: Double, long: Double, radius: Double,
               onDone: @escaping ([Snap]) -> Void,
               onError: @escaping (String) -> Void) {
    let gfSnap = GeoFire(firebaseRef: ref.child("snap/geofire"))
    let center = CLLocation(latitude: lat, longitude: long)
    let circleQuery = gfSnap.query(at: center, withRadius: radius)
    var ret: [Snap] = []
    var pending = 0
    var ready = false
    var done = false
    _ = circleQuery.observe(.keyEntered, with: { (key: String!, location: CLLocation!) in
        pending += 1
        if done {
            return
        }
        ref.child("snap/all").child(key).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let name = value?["Store_Name"] as? String ?? ""
            let zip  = value?["Zip5"] as? String ?? ""
            let address = value?["Address"] as? String ?? ""
            let city = value?["City"] as? String ?? ""
            let state = value?["State"] as? String ?? ""
            let latlong = (0.0, 0.0); // Todo fix
            ret += [Snap(name: name, address: address, cityName: city, state: state, zip: zip, latlong: latlong)]
            pending -= 1
            if ready && pending == 0 && !done {
                done = true
                onDone(ret)
            }
        }) { (error) in
            print(error.localizedDescription)
            if !done {
                done = true
                onError(error.localizedDescription)
            }
        }
    })
    _ = circleQuery.observeReady {
        print("Ready!")
        ready = true
    }
}

// Given a coordinate and radius, get all markets in an area.
// The query is async, so you must pass in two callbacks for
// either an Array of Market items, or a string describing the error.
func queryMarkets(lat: Double, long: Double, radius: Double,
               onDone: @escaping ([Market]) -> Void,
               onError: @escaping (String) -> Void) {
    let gfMarkets = GeoFire(firebaseRef: ref.child("markets/geofire"))
    let center = CLLocation(latitude: lat, longitude: long)
    let circleQuery = gfMarkets.query(at: center, withRadius: radius)
    var ret: [Market] = []
    var pending = 0
    var ready = false
    var done = false
    _ = circleQuery.observe(.keyEntered, with: { (key: String!, location: CLLocation!) in
        pending += 1
        if done {
            return
        }
        ref.child("markets/all").child(key).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let name = value?["MarketName"] as? String ?? ""
            let zip  = value?["zip"] as? String ?? ""
            let address = value?["Address"] as? String ?? ""
            let city = value?["city"] as? String ?? ""
            let state = value?["State"] as? String ?? ""
            let facebook = value?["Facebook"] as? String ?? ""
            let website = value?["Website"] as? String ?? ""
            let latlong = (0.0, 0.0); // Todo fix
            let tags: [String] = []; // Todo fix
            ret += [Market(
                name: name,
                address: address,
                cityName: city,
                state: state,
                zip: zip,
                tags: tags,
                facebook: facebook,
                website: website,
                latlong: latlong)]
            pending -= 1
            if ready && pending == 0 && !done {
                done = true
                onDone(ret)
            }
        }) { (error) in
            print(error.localizedDescription)
            if !done {
                done = true
                onError(error.localizedDescription)
            }
        }
    })
    _ = circleQuery.observeReady {
        print("Ready!")
        ready = true
    }
}
