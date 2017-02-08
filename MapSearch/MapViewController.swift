//
//  MapViewController.swift
//  MapSearch
//
//  Created by Bryan on 7/02/17.
//  Copyright © 2017 BolivarBryan. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    var places:[Address] = []
    @IBOutlet weak var mapView: MKMapView!
    var saveButtonItem:UIBarButtonItem?
    var deleteButtonItem:UIBarButtonItem?
    var selectedPlace:Address! = nil
    var storedAnnotations:[(annotation: MKAnnotation,place: Address)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.centerMapInplaces()
        saveButtonItem = UIBarButtonItem(title: NSLocalizedString("SAVE", comment: "save"), style: .done, target: self, action: #selector(saveSelectedPlace))
        deleteButtonItem = UIBarButtonItem(title: NSLocalizedString("DELETE", comment: "delete"), style: .done, target: self, action: #selector(deleteSelectedPlace))

        self.mapView.delegate = self
        self.navigationItem.rightBarButtonItem = nil
        
        /*
        //Enabling this code will disable save and delete events for multiple places
        if self.places.count > 1 {
            deleteButtonItem = nil
            saveButtonItem = nil
        }
        */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func saveSelectedPlace(){
        DatabaseManager.sharedInstance.saveAddress(address: selectedPlace) { (response) in
            switch response {
            case .alreadySaved:
                    print("already exists")
            case .error:
                    print("error saving")
            case .success:
                    print("Data Saved")
                    self.navigationItem.rightBarButtonItem = deleteButtonItem
            }
        }
    }
    
    func deleteSelectedPlace() {
        
        DatabaseManager.sharedInstance.deleteAddress(address: selectedPlace)
        self.navigationItem.rightBarButtonItem = saveButtonItem
        
    }
    
    func centerMapInplaces() {
        for place in places {
            let coordinate = CLLocationCoordinate2D(latitude: place.location.latitude, longitude: place.location.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = place.formattedAddress
            annotation.subtitle = place.formattedLocation()
            storedAnnotations.append((annotation, place))
        }
        var annotationObjects:[MKAnnotation] = []
        var _ = storedAnnotations.map { tuple in
            annotationObjects.append(tuple.annotation)
        }
        mapView.addAnnotations(annotationObjects)
        mapView.showAnnotations(annotationObjects, animated: true)
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.mapView.setCenter((view.annotation?.coordinate)!, animated: true)
        self.mapView.showAnnotations([view.annotation!], animated: true)
        

        for (annotation, place) in self.storedAnnotations {
            if annotation === view.annotation {
                selectedPlace = place
            }
        }
        
        if let _ = DatabaseManager.sharedInstance.findAddressInDatabase(address: selectedPlace) {
            self.navigationItem.rightBarButtonItem = deleteButtonItem
        }else{
            self.navigationItem.rightBarButtonItem = saveButtonItem
        }
        
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        self.navigationItem.rightBarButtonItem = nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
       
    }
}
