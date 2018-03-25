import UIKit
import GoogleMaps
import GooglePlaces

class MyMapController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting up the initial camera for the Google Maps link
        GMSServices.provideAPIKey("AIzaSyDHv1H8F-f-lpmRE-k-s229071HjCcWOzE")
        let camera=GMSCameraPosition.camera(withLatitude: 42.349923, longitude:  -71.107893, zoom: 15)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view=mapView
        
        //array for locations
        struct location{
            var coordinate: CLLocationCoordinate2D
            var name: String
        }
        
        var locationArray = [location]()
        
        let tAnthonys = location(coordinate: CLLocationCoordinate2DMake(42.351463, -71.121460), name: "T'Anthonys")
        locationArray.append(tAnthonys)
        
        let starMarket = location(coordinate: CLLocationCoordinate2DMake(42.352070, -71.122032), name: "Star Market")
        locationArray.append(starMarket)
        
        
        //looping through array and putting them in the maps
        for index in 0..<locationArray.count{
            let desiredLocation=CLLocationCoordinate2D(latitude: locationArray[index].coordinate.latitude,longitude: locationArray[index].coordinate.longitude)
            let marker = GMSMarker(position: desiredLocation)
            marker.title=locationArray[index].name
            marker.map=mapView
        }
        
        
        
        
    }
        
        
}

