//
//  MapViewController.swift
//  DigitalVeil
//
//  Created by Al Rodríguez on 14/02/2020.
//  Copyright © 2020 Al Rodríguez. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController {
    
    //Initialization 
    @IBOutlet var mapView: MKMapView!
    var data: [MapModels] = []
    let regionRadius: CLLocationDistance = 1000
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = DataHelpers.parseCsvData()
        
        for point in data {
            mapView.addAnnotation(addNotationToMap(latitude: point.Latitude,longitude: point.Longitude, title: point.App))
            
        }
        
        mapView.setRegion(centerMapOnLocation(latitude: data[0].Latitude, longitude: data[0].Longitude), animated: true)

    }
    
    
    func centerMapOnLocation(latitude: Double , longitude: Double) -> MKCoordinateRegion{
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let regionRadius: CLLocationDistance = 5000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        return coordinateRegion
        
    }
    
    func addNotationToMap(latitude: Double , longitude: Double, title: String) ->  MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude )
        annotation.title = title
        annotation.subtitle = title
        return annotation
    }
}
