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
}
