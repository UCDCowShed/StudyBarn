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
        print("start reading data")
        // Get User Data
        let document = try? await userAreaTrackedDocument(userId: userId).getDocument()
        let curDateInDate = Date()
        print("now need to check document")
        // Convert data to UserAreaTrackedModel format
        if document?.exists ?? false {
            print("got something from database")
            guard let document = document else {
                print("nothing found...")
                return
            }
            let userTrackedData = try document.data(as: UserAreaTrackedModel.self)
            
            // AreaId exists, increment value by one if data modified is not today
            if userTrackedData.areaTracked[areaId] != nil {
                print("areaId exists")
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
                    guard let count = userTrackedData.areaTracked[areaId]?.count else {
                        print("Could not get count..")
                        return
                    }
                    let newData = [areaId: AreaTrack(count: count + 1, dateModified: curDateInDate)]
                    let newInsertData = UserAreaTrackedModel(userId: userId, areaTracked: newData)
                    try userAreaTrackedDocument(userId: userId).setData(from: newInsertData, merge: true)
                    print("Saved tracked data (areaId already existed)")
                }
                
                return
            }
            print("end of checking document exists")
        }
        // Create new data if does not exist
        print("no data found, try saving the data here")
        let newData = [areaId: AreaTrack(count: 1, dateModified: curDateInDate)]
        let newInsertData = UserAreaTrackedModel(userId: userId, areaTracked: newData)
        try userAreaTrackedDocument(userId: userId).setData(from: newInsertData, merge: true)
        print("Saved tracked data")
    }
}
