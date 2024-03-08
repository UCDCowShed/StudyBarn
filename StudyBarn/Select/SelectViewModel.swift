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
    @Published var areas: [AreaModel]? = []
    @Published var areaCoordinates: [String: CLLocationCoordinate2D] = [:]
    
    func getCoordinates(areas: [AreaModel]){
        areaCoordinates = [:]
        for area in areas {
            print(area.name)
            areaCoordinates[area.name] = CLLocationCoordinate2D(latitude: area.latitude ?? -1, longitude: area.longitude ?? -1)
        }
    }
    
    func loadAllArea() async throws {
        areas = try await AreaManager.shared.getAllArea()
        if let areas = areas {
            self.getCoordinates(areas: areas)
        }
    }
}
