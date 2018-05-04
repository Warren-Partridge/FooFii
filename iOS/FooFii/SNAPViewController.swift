//
//  SNAPViewController.swift
//  FooFii
//
//  Created by Calvin Rose on 5/4/18.
//  Copyright © 2018 Calvin Rose. All rights reserved.
//

import UIKit
import SwiftLocation
import CoreLocation
import MapKit

// The custom TableViewCell for showing the SNAP view.
class SNAPCell: UITableViewCell {
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
}

class SNAPViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Table of SNAP seach results
    @IBOutlet weak var snapTable: UITableView!
    
    let distanceFormatter = MKDistanceFormatter()
    
    // The snaps we found
    var snaps: [Snap] = [];
    var isSearching: Bool = false
    var lastLocation: CLLocation = CLLocation(latitude: 0, longitude: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        distanceFormatter.unitStyle = .full
        snapTable.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Called when the users searchs for SNAP locations
    @IBAction func actionSearch(_ sender: Any) {
        if isSearching {
            return
        }
        isSearching = true
        Locator.currentPosition(accuracy: .neighborhood, onSuccess: { location in
            self.lastLocation = location
            querySnap(center: location, radius: 1, onDone: { queryResults in
                let sorted = queryResults.sorted(by: {l, r in
                    return l.latlong.distance(from: location) < r.latlong.distance(from: location)
                })
                
                self.isSearching = false
                self.snaps = sorted
                self.snapTable.reloadData()
            }, onError: { err in
                self.isSearching = false
                print("error :( \(err)")
            })
        }, onFail: { err, last in
            self.isSearching = false
            print("error :( \(err)")
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snaps.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SnapCell", for: indexPath) as! SNAPCell
        
        let snap = snaps[indexPath.row]
        cell.nameLabel?.text = snap.name
        let distanceString = distanceFormatter.string(fromDistance: lastLocation.distance(from: snap.latlong))
        cell.distanceLabel?.text = distanceString
        cell.addressLabel?.text = snap.address
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let selectedSnap = snaps[indexPath.row]
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let destinationVC = storyBoard.instantiateViewController(withIdentifier: "SNAPDetailViewController") as! SNAPDetailViewController
        destinationVC.snap = selectedSnap
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Make the cells a bit larger than the default
        return 80;
    }

}
