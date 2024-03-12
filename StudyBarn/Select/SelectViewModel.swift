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
    
    
    // Initialize Monitor with given Coordinates
    // should happen only once with all the area when app starts
    func initializeMonitor() async {
        monitor = await CLMonitor("StudySpotMotitor")
        
        guard let monitor = monitor else {
            print("Monitor is not initialized successfully.")
            return
        }
        
        // Convert Coordinates into conditions for monitor and add to the monitor
        for areaCoor in areaCoordinates {
            // User within 15 meters of this area will be considered to be "entered"
            let areaCondition = CLMonitor.CircularGeographicCondition(center: areaCoor.value, radius: 10)
            // Identifier as areaId
            await monitor.add(areaCondition, identifier: areaCoor.key, assuming: .unsatisfied)
        }
    }
    
    func startMonitorAreas() async {
        if monitor == nil {
            monitor = await CLMonitor("StudySpotMotitor")
        }
        
        Task {            
            guard let monitor else { return }
            
            for try await event in await monitor.events {
                switch event.state {
                // User entered some studyspots
                case .satisfied:
                    // Save User Movement into database
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
