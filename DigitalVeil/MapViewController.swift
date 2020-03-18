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
    //Spinner initiallization
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    //Initialization 
    @IBOutlet var mapView: MKMapView!
    var data: [App] = []
    var isLoaded : Bool = false
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMapData()
        
        //Spinner config
        DataHelpers.spinnerConfig(activityIndicator: activityIndicator, UIView: self)
        
        //Add spinner to the view
        self.view.addSubview(activityIndicator)
        
        if(!data.isEmpty){
            for point in data {
                //Call of the annotations function
                mapView.addAnnotation(addNotationToMap(latitude: point.Latitude,longitude: point.Longitude, title: point.App))
            }
            
            //Call of the region method
            mapView.setRegion(centerMapOnLocation(latitude: data[0].Latitude, longitude: data[0].Longitude), animated: true)
        }
    }
    
    //Center the view of the map in a region in order to see something the first time it load
    func centerMapOnLocation(latitude: Double , longitude: Double) -> MKCoordinateRegion{
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let regionRadius: CLLocationDistance = 5000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        return coordinateRegion
        
    }
    
    //Add annotations of the places to the map
    func addNotationToMap(latitude: Double , longitude: Double, title: String) ->  MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude )
        annotation.title = title
        annotation.subtitle = title
        return annotation
    }
    
    func getMapData() {
        //Start loading animation of the spinner
        DataHelpers.toggleLoadingSpinner(animate: true, activityIndicator: activityIndicator)
        
        //Make the data request
        NetworkUtils.getAppsLocationFake(completion: {
            response in
            
            if let appsData = response {
                self.data = appsData
            } else {
                //Alert message
                self.present(DataHelpers.displayAlert(userMessage: "Something went wrong! Try again later", alertType: 0), animated: true, completion: nil)
            }
            
            DataHelpers.toggleLoadingSpinner(animate: false, activityIndicator: self.activityIndicator)
            
            self.isLoaded = true
         })
        
    }
}
