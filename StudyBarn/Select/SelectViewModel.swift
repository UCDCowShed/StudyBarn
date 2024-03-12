//
//  ExploreViewModel.swift
//  StudyBarn
//
//  Created by JinLee on 2/29/24.
//

import Foundation
import MapKit

@MainActor
final class SelectViewModel: ObservableObject {
    @Published var areasIds: [String] = []
    @Published var areasHashmap: [String: AreaModel] = [:]
    @Published var areaCoordinates: [String: CLLocationCoordinate2D] = [:]
    @Published var monitor: CLMonitor? = nil
    @Published var userId: String? = nil
    
    // Set User Id
    func setUserId(userId: String?){
        guard let userId = userId else { return }
        
        self.userId = userId
    }
    
    // Update areas hashmap and coordinates
    func loadNewAreas(newAreas: [AreaModel]) {
        areaCoordinates = [:]
        areasHashmap = [:]
        areasIds = []
        
        for newArea in newAreas {
            // update area coordinates
            areaCoordinates[newArea.areaId] = CLLocationCoordinate2D(latitude: newArea.latitude ?? -1, longitude: newArea.longitude ?? -1)
            // update areas' Ids
            areasIds.append(newArea.areaId)
            // update areas
            areasHashmap[newArea.areaId] = newArea
        }
    }
    
    func loadAllArea() async throws {
        let areas = try await AreaManager.shared.getAllArea()
        // Update areas hashmap and coordinates
        self.loadNewAreas(newAreas: areas)
    }
    
    // Save User's Entrance to the studySpots
    func saveUserTrackingInfo(userId: String, areaId: String) async throws {
        try await MapManager.shared.saveUserTrackedData(userId: userId, areaId: areaId)
    }
    
    // Initialize Monitor with given Coordinates
    // should happen only once with all the area when app starts
    func initializeMonitor(userId: String?) async {
        print("Initialize monitor")
        if self.userId == nil {
            setUserId(userId: userId)
        }
        
        guard let userIdSaved = self.userId else {
            print("Error with initializing monitor..userId not saved.")
            return
        }
        
        monitor = await CLMonitor(userIdSaved)
        
        guard let monitor = monitor else {
            print("Monitor is not initialized successfully.")
            return
        }
        
        // Convert Coordinates into conditions for monitor and add to the monitor
        for areaCoor in areaCoordinates {
            // User within 15 meters of this area will be considered to be "entered"
            let areaCondition = CLMonitor.CircularGeographicCondition(center: areaCoor.value, radius: 5)
            // Identifier as areaId
            await monitor.add(areaCondition, identifier: areaCoor.key, assuming: .unsatisfied)
        }
    }
    
    func startMonitorAreas() async throws {
        print("start monitor")
        if monitor == nil {
            guard let userId = self.userId else {
                print("Error with starting monitor..userId not saved.")
                return
            }
            monitor = await CLMonitor(userId)
        }
        
        Task {            
            guard let monitor = self.monitor else {
                print("Error with starting monitor.. monitor does not exist..")
                return
            }
            
            for try await event in await monitor.events {
                switch event.state {
                // User entered some studyspots
                case .satisfied:
                    if let userId = userId {
                        // Save User Movement into database
                        try await saveUserTrackingInfo(userId: userId, areaId: event.identifier)
                    }
                    else {
                        print("Error saving tracked data...userId does not exists..")
                    }
                    print("Entered: " + event.identifier)
                
                // User exited out of the studySpots
                case .unknown, .unsatisfied:
                    print("Exited: " + event.identifier)
                    
                default:
                    print("No Location Registered")
                }
            }
        }
    }
}
