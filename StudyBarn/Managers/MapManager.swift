//
//  MapManager.swift
//  StudyBarn
//
//  Created by JinLee on 3/11/24.
//

import Foundation
import MapKit

final class MapManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = MapManager()
    private override init() {}
    
    // By Default, assume that user turned off location tracking on their phone settings
    var locationManager: CLLocationManager? = nil
    
    func checkIfLocationServiceIsEnabled() {
        DispatchQueue.global().async {
            // Check Location Service status
            if CLLocationManager.locationServicesEnabled() {
                
                // Critical Section
                DispatchQueue.main.async {
                    self.locationManager = CLLocationManager()
                    guard let locationManager = self.locationManager else { return }
                    locationManager.delegate = self
                }
                
            } else {
                print("Location Service is turned off. The User needs to enable this from the settings.")
            }
        }
    }
    
    func checkLocationAuthorization() {
        guard let locationManager = self.locationManager else { return }
        
        switch(locationManager.authorizationStatus) {
            
        case .notDetermined:
            // Ask Permission
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your Location is restricted..")
        case .denied:
            print("Location Permission Denied. The User needs to enable this from the settings.")
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
    
    // Triggered automatically when User changed authorization from their settings
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Check authorization when user changed auth settings
        checkLocationAuthorization()
    }
}
