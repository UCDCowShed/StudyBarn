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
    
    // Get User Tracked Info
    func getUserTrackedInfo(userId: String) async throws -> [String: AreaTrackModel] {
        let document = try? await userAreaTrackedDocument(userId: userId).getDocument()
        
        if document?.exists ?? false {
            guard let document = document else {
                print("nothing found...")
                return [:]
            }
            let userTrackedData = try document.data(as: UserAreaTrackedModel.self)
            
            return userTrackedData.areaTracked
        }
        return [:]
    }
    
    // Get Most Visited Area
    func getMostVisitedArea(userId: String) async throws -> AreaModel? {
        let document = try? await userAreaTrackedDocument(userId: userId).getDocument()
        
        if document?.exists ?? false {
            guard let document = document else {
                return nil
            }
            let userTrackedData = try document.data(as: UserAreaTrackedModel.self)
            
            // Nothing Found
            if userTrackedData.areaTracked.keys.count == 0 {
                return nil
            }
            
            // Find Max Visited
            var maxVisited: AreaTrackModel?
            var maxVisitedAreaId: String?
            for areaId in userTrackedData.areaTracked.keys {
                let newArea = userTrackedData.areaTracked[areaId]
                
                // First Time
                if maxVisited == nil {
                    maxVisited = newArea
                    maxVisitedAreaId = areaId
                    continue
                }
                
                if maxVisited?.count ?? 0 < newArea?.count ?? 0 {
                    maxVisited = newArea
                    maxVisitedAreaId = areaId
                }
            }
            
            guard let maxVisitedAreaId = maxVisitedAreaId else {
                print("Nothing Found")
                return nil
            }
            
            // Get Area Info with Max Visited
            let areaInfo = try await AreaManager.shared.getArea(areaId: maxVisitedAreaId)
            
            return areaInfo
        }
        
        return nil
    }
    
    // Save Tracked user's data into the database
    func saveUserTrackedData(userId: String, areaId: String) async throws {
        // Get User Data
        let document = try? await userAreaTrackedDocument(userId: userId).getDocument()
        let curDateInDate = Date()
        // Convert data to UserAreaTrackedModel format
        if document?.exists ?? false {
            guard let document = document else {
                return
            }
            let userTrackedData = try document.data(as: UserAreaTrackedModel.self)
            
            // AreaId exists, increment value by one if data modified is not today
            if userTrackedData.areaTracked[areaId] != nil {
                
                // Count entered
                guard let count = userTrackedData.areaTracked[areaId]?.count else {
                    return
                }
                let newData = [areaId: AreaTrackModel(count: count + 1, dateModified: curDateInDate)]
                let newInsertData = UserAreaTrackedModel(userId: userId, areaTracked: newData)
                try userAreaTrackedDocument(userId: userId).setData(from: newInsertData, merge: true)

                return
            }
        }
        // Create new data if does not exist
        let newData = [areaId: AreaTrackModel(count: 1, dateModified: curDateInDate)]
        let newInsertData = UserAreaTrackedModel(userId: userId, areaTracked: newData)
        try userAreaTrackedDocument(userId: userId).setData(from: newInsertData, merge: true)
    }
}
