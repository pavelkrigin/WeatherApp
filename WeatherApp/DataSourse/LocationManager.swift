//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Pavel Krigin on 18.03.2023.
//

import Foundation
import MapKit
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    var location: (Double, Double) = (latitude: 0, longitude: 0)
    func setUpLocationManager() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled(){
                self.locationManager.startUpdatingLocation()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.location.0 = locValue.latitude
        self.location.1 = locValue.longitude
        print("locations = \(locValue.latitude) \(locValue.longitude)")
                
    }
}





