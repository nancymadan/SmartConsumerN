//
//  LocationManager.swift
//  BusinessDirectory
//
//  Created by Aseem 13 on 18/01/17.
//  Copyright © 2017 Taran. All rights reserved.
//

import UIKit
import CoreLocation
class LocationManager: NSObject,CLLocationManagerDelegate {
    
    var locationManager : CLLocationManager?
    var currentLoc : CLLocation?
    
    override init() {
        super.init()
        locationInitializer()
        updateLocation()
    }
    
    static let sharedInstance = LocationManager()
    
    func updateUserLocation(){
        locationInitializer()
        updateLocation()
    }
    
    func updateLocation(){
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
    }
    
    func locationInitializer(){
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        if ((locationManager?.requestWhenInUseAuthorization()) != nil) {
            locationManager?.requestWhenInUseAuthorization()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLoc = locations.last
        locationManager?.stopUpdatingLocation()
        locationManager?.delegate = nil
    }
    
}
