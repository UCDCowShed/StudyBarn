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
    @Published var userId: String? = nil
    @Published var areaVisitFrequencies: [String: AreaTrackModel] = [:]
    
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
        // areaIds
        var closedAreas: [String] = []
        let todayDate: String = Utilities.shared.getCurrentDate()
        
        for newArea in newAreas {
            // update area coordinates
            areaCoordinates[newArea.areaId] = CLLocationCoordinate2D(latitude: newArea.latitude ?? -1, longitude: newArea.longitude ?? -1)
            // update areas' Ids
            
            // Display Opened Areas first than the closed areas
            if !AreaManager.shared.determineOpenOrClose(openHour: newArea.openHour[todayDate], closeHour: newArea.closeHour[todayDate]) {
                // Closed
                closedAreas.append(newArea.areaId)
            }
            else {
                // Opened
                areasIds.append(newArea.areaId)
            }
            
            // update areas
            areasHashmap[newArea.areaId] = newArea
        }
        
        // Sorted By Opened Areas
        areasIds.append(contentsOf: closedAreas)
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
    func initializeMonitor() async -> CLMonitor {
        print("Initialize monitor")
        return await CLMonitor("StudySpotMonitor")
    }
    
    func setConditionOnMonitor(monitor: CLMonitor?) async {
        print("setting conditions on monitor")
        // Convert Coordinates into conditions for monitor and add to the monitor
        for areaCoor in areaCoordinates {
            // User within 3 meters of this area will be considered to be "entered"
            let areaCondition = CLMonitor.CircularGeographicCondition(center: areaCoor.value, radius: 3)
            // Identifier as areaId
            await monitor?.add(areaCondition, identifier: areaCoor.key, assuming: .unsatisfied)
        }
        
    }
    
    // Happends when the user logs in
    func startMonitorAreas(monitor: CLMonitor?) async {
        print("start monitor")
        guard let monitor = monitor else {
            print("Error with starting monitor.. monitor does not exist..")
            return
        }
        
        Task {

            for try await event in await monitor.events {
                switch event.state {
                    // User entered some studyspots
                case .satisfied:
                    print("Entered: " + event.identifier)
                    if let userId = self.userId {
                        print("try saving tracked data")
                        // Save User Movement into database
                        do {
                            try await saveUserTrackingInfo(userId: userId, areaId: event.identifier)
                            print("seems like saved the tracked data")
                        }
                        catch {
                            print("Failed saving data: ")
                            print(error)
                        }
                    }
                    else {
                        print("Error saving tracked data...userId does not exists..")
                    }
                    print("ran everything")
                    
                    // User exited out of the studySpots
                case .unknown, .unsatisfied:
                    print("Exited: " + event.identifier)
                    
                default:
                    print("No Location Registered")
                }
            }
        }
    }
    
    // Happens when the user logs out
    func removeMonitorAreas(monitor: CLMonitor?) async {
        print("Stop Monitor")
        
        if let identifiers = await monitor?.identifiers {
            for anIdentifier in identifiers {
                await monitor?.remove(anIdentifier)
            }
        }
    }
    
    func loadAreaVisitFrequencies(userId: String?) async throws {
        guard let userId = userId else { return }
        
        let frequencies = try await MapManager.shared.getUserTrackedInfo(userId: userId)
        areaVisitFrequencies = frequencies
    }
}
