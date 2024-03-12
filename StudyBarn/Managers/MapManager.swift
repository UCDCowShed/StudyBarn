//
//  MapManager.swift
//  StudyBarn
//
//  Created by JinLee on 3/11/24.
//

import Foundation
import MapKit
import FirebaseFirestore
import FirebaseFirestoreSwift

final class MapManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = MapManager()
    private override init() {}
    
    private let userAreaTrackedCollection = Firestore.firestore().collection("userAreaTracked")
    
    private func userAreaTrackedDocument(userId: String) -> DocumentReference {
        return userAreaTrackedCollection.document(userId)
    }
    
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
    
    // Save Tracked user's data into the database
    func saveUserTrackedData(userId: String, areaId: String) async throws {
        // Get User Data
        let document = try? await userAreaTrackedDocument(userId: userId).getDocument()
        let curDateInDate = Date()
        
        // Convert data to UserAreaTrackedModel format
        if let document = document {
            let userTrackedData = try document.data(as: UserAreaTrackedModel.self)
            
            // AreaId exists, increment value by one if data modified is not today
            if userTrackedData.areaTracked[areaId] != nil {
                let lastDateModified = userTrackedData.areaTracked[areaId]?.dateModified
                guard let convertedLastDate = Utilities.shared.getYearMonthDay(dateToConvert: lastDateModified) else {
                    print("Error with saving tracked data into the firebase..")
                    return
                }
                guard let curDate = Utilities.shared.getYearMonthDay(dateToConvert: curDateInDate) else {
                    print("Error with saving tracked data into the firebase..")
                    return
                }
                
                // current date has passed one more day than the last date modified: save data
                if convertedLastDate < curDate {
                    let count = userTrackedData.areaTracked[areaId]?.count
                    let newData = AreaTrack(count: count ?? 0 + 1, dateModified: curDateInDate)
                    try await userAreaTrackedDocument(userId: userId).setData([ areaId: newData ], merge: true)
                    print("Saved tracked data (areaId already existed)")
                }
                
                return
            }
        }
        // Create new data if does not exist
        let newData = AreaTrack(count: 1, dateModified: curDateInDate)
        try await userAreaTrackedDocument(userId: userId).setData([ areaId: newData ], merge: true)
        print("Saved tracked data")
    }
}
