//
//  LocationManager.swift
//  simple-weather-app
//
//  Created by Adrian Kasiczak on 08/07/2019.
//  Copyright © 2019 Adrian Kasiczak. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    private var locationAvaliable = true
    
    private var latitude: CLLocationDegrees = 0.0
    private var longitude: CLLocationDegrees = 0.0
    
    static let shared = LocationManager()
    
    override init() {
        super.init()
        setupLocationManager()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue: CLLocationCoordinate2D? = manager.location?.coordinate
        if (locValue != nil) {
            latitude = locValue!.latitude
            longitude = locValue!.longitude
            
            locationAvaliable = true
            
            updateLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                locationAvaliable = false
                break
            case .authorizedAlways, .authorizedWhenInUse:
                locationAvaliable = true
                locationManager.requestLocation()
                break
            }
        }
        else {
            locationAvaliable = false
        }
    }
    
    @objc func updateLocation() {
        if (locationManager.delegate == nil) {
            locationManager.delegate = self
        }
        
        locationManager.requestLocation()
    }
    
    @objc func isLocactionAvaliable() -> Bool {
        return locationAvaliable && latitude != 0.0 && longitude != 0.0
    }
    
    
    @objc func getLatitude() -> Double {
        return latitude
    }
    
    @objc func getLongitude() -> Double {
        return longitude
    }
    
    fileprivate func setupLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
    }
}
