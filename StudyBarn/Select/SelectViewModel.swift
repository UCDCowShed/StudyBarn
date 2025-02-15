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
    
    // Maps areaID to the areaModel that contains all the information
    @Published var areasHashmap: [String: AreaModel] = [:]
    
    // Maps the areaID to its coordinates so that we can access it from the map
    @Published var areaCoordinates: [String: CLLocationCoordinate2D] = [:]
    
    @Published var userId: String? = nil
    
    // Maps the areaID to the frequency data.
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
    func saveTrackedInfo(userId: String, areaId: String) async throws {
        // Save Data on User
        try await MapManager.shared.saveUserTrackedData(userId: userId, areaId: areaId)
        // Save Data on Area
        try await AreaManager.shared.countAreaVisited(areaId: areaId)
    }
    
    // Initialize Monitor with given Coordinates
    // should happen only once with all the area when app starts
    func initializeMonitor() async -> CLMonitor {
        return await CLMonitor("StudySpotMonitor")
    }
    
    func setConditionOnMonitor(monitor: CLMonitor?) async {
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
        guard let monitor = monitor else {
            print("Error with starting monitor.. monitor does not exist..")
            return
        }
        
        Task {

            for try await event in await monitor.events {
                switch event.state {
                    // User entered some studyspots
                case .satisfied:
                    if let userId = self.userId {
                        // Save User Movement into database
                        do {
                            try await saveTrackedInfo(userId: userId, areaId: event.identifier)
                        }
                        catch {
                            print("Failed saving data: ")
                            print(error)
                        }
                    }
                    else {
                        print("Error saving tracked data...userId does not exists..")
                    }
                    
                    // User exited out of the studySpots
                case .unknown, .unsatisfied:
                    print("Unknown Event..")
                default:
                    print("No Location Registered")
                }
            }
        }
    }
    
    // Happens when the user logs out
    func removeMonitorAreas(monitor: CLMonitor?) async {
        if let identifiers = await monitor?.identifiers {
            for anIdentifier in identifiers {
                await monitor?.remove(anIdentifier)
            }
        }
    }
    
    // Get the frequency data from firebase
    func loadAreaVisitFrequencies(userId: String?) async throws {
        guard let userId = userId else { return }
        
        let frequencies = try await MapManager.shared.getUserTrackedInfo(userId: userId)
        areaVisitFrequencies = frequencies
    }
}
