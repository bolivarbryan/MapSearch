//
//  MapViewController.swift
//  MapSearch
//
//  Created by Bryan on 7/02/17.
//  Copyright © 2017 BolivarBryan. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    var places:[Address] = []
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if places.count == 1 {
            self.centerMapInPlace(place: places[0])
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func centerMapInPlace(place: Address) {
        let coordinate = CLLocationCoordinate2D(latitude: place.location.latitude, longitude: place.location.longitude)
        let span = MKCoordinateSpanMake(0.075, 0.075)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = place.formattedAddress
        annotation.subtitle = place.formattedLocation()
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
    }

}
