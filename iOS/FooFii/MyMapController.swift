import UIKit
import GoogleMaps
import GooglePlaces

class MyMapController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //to provide map markers for google maps link
        GMSServices.provideAPIKey("AIzaSyDHv1H8F-f-lpmRE-k-s229071HjCcWOzE")
        let camera=GMSCameraPosition.camera(withLatitude: 42.349923, longitude:  -71.107893, zoom: 15)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view=mapView

        let desiredLocation = CLLocationCoordinate2DMake(42.352070, -71.122032)
        let marker = GMSMarker(position: desiredLocation)
        marker.title="Star Market"
        marker.map=mapView
        
        let desiredLocation2 = CLLocationCoordinate2DMake(42.351463, -71.121460)
        let marker2 = GMSMarker(position: desiredLocation2)
        marker2.title="T Anthony's"
        marker2.map=mapView
        
    }
        
        
}

