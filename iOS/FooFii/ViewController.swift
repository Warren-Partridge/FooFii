//
//  ViewController.swift
//  Foofi Maps View IOS
//
//  Created by William Munoz on 2/6/18.
//  Copyright © 2018 William Munoz. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit

class ViewController: UIViewController{
    
    //Google Maps Link
    var latitude: CLLocationDegrees = 42.351462
    var longitude: CLLocationDegrees = -71.121457
    
    @IBAction func GoogleMapsLink(_ sender: Any) {
        
        
        let regionDistance: CLLocationDistance = 1000;
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "EBT destination"
        mapItem.openInMaps(launchOptions: options)
    }
    
    
    //Side Menu
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    var menuShowing=false
    
    @IBAction func openMenu(_ sender: Any) {
        if(menuShowing){
            leadingConstraint.constant = -140
        }else{
            leadingConstraint.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
                })
            
        }
        
        menuShowing = !menuShowing
    }
    
    
    //variables from storyboard
    @IBOutlet weak var yellow_box: UITextView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var filterButton: UIButton!
    
    @IBOutlet weak var bottomButton1: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //shadow for view_in_List
        yellow_box.clipsToBounds = false
        yellow_box.layer.shadowOpacity=0.4
        yellow_box.layer.shadowOffset = CGSize(width: 1, height: 7)
        
        //getting rid of navigation controller border
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //adding shadow to the text
        searchBar.layer.shadowColor = UIColor.black.cgColor
        searchBar.layer.shadowRadius = 3.0
        searchBar.layer.shadowOpacity = 1.0
        searchBar.layer.shadowOffset = CGSize(width: 4, height: 4)
        searchBar.layer.masksToBounds = false
        
        filterButton.titleLabel?.layer.shadowRadius = 3
        filterButton.titleLabel?.layer.shadowColor = UIColor.black.cgColor
        filterButton.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 1)
        filterButton.titleLabel?.layer.shadowOpacity = 0.4
        filterButton.titleLabel?.layer.masksToBounds = false
        
        //rounding edges of the two button
        filterButton.layer.cornerRadius = 5
        filterButton.layer.borderWidth = 1
        filterButton.layer.borderColor = UIColor.clear.cgColor
        
        searchBar.layer.cornerRadius = 10
        searchBar.clipsToBounds = true
        

        
    }
    
    
    
    
    
    
   
    
   
}

