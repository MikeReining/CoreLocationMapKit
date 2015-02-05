//
//  ViewController.swift
//  CoreLocationMapKit
//
//  Created by Michael Reining on 2/5/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var userLocation: CLLocationCoordinate2D?
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Obtaining Location Information Permission
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Location Manager Delegate
    
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        println("New location")
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        //1 grab current location
        var currentLocation = locations.last as CLLocation
        //2 create location point for map based on current location
        var location = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        //3 define layout for map
        let span = MKCoordinateSpanMake(0.02, 0.02)
        let userPoint = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(userPoint, animated: true)
        
        //4 add annotation to current location
        let annotation = MKPointAnnotation()
        annotation.setCoordinate(location)
        annotation.title = "Where am I?"
        annotation.subtitle = "I am here!"
        mapView.addAnnotation(annotation)
        //5 stop updatinglocation
        locationManager.stopUpdatingLocation()

        
    }

}



