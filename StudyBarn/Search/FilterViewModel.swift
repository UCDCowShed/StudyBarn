//
//  FilterViewModel.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/29/24.
//

import SwiftUI

struct FilterModel: Identifiable, Codable {
    var id: Int
    var name: String
    var selected: Bool
}


class FilterViewModel: ObservableObject {
    @Published var atmosphereFilter = [
        FilterModel(id: 0, name: SubAreaModel.CodingKeys.outdoors.rawValue, selected: false),
    ]
    
    @Published var volumeFilter = [
        FilterModel(id: 0, name: SubAreaModel.CodingKeys.groupStudy.rawValue, selected: false),
    ]
    
    @Published var featureFilter = [
        FilterModel(id: 0, name: SubAreaModel.CodingKeys.microwave.rawValue, selected: false),
        FilterModel(id: 1, name: SubAreaModel.CodingKeys.printer.rawValue, selected: false),
        FilterModel(id: 2, name: SubAreaModel.CodingKeys.outlets.rawValue, selected: false),
        FilterModel(id: 3, name: SubAreaModel.CodingKeys.computers.rawValue, selected: false),
        FilterModel(id: 4, name: SubAreaModel.CodingKeys.dining.rawValue, selected: false),
    ]
    
    func atmoFilterRowTapped(filterRow: FilterModel) {
        self.atmosphereFilter[filterRow.id].selected.toggle()
    }
    
    func volumeFilterRowTapped(filterRow: FilterModel) {
        self.volumeFilter[filterRow.id].selected.toggle()
    }
    
    func featureFilterRowTapped(filterRow: FilterModel) {
        self.featureFilter[filterRow.id].selected.toggle()
    }
    
    // Get Filtered Areas
    func getFilteredAreas(atmosphereFilter: [FilterModel], volumeFilter: [FilterModel], featureFilter: [FilterModel]) async throws -> [AreaModel]? {
        let filteredAreas = try await AreaManager.shared.getFilteredArea(atmosphereFilter: atmosphereFilter, volumeFilter: volumeFilter, featureFilter: featureFilter)
        
        // Filter Applied
        if let filteredAreas = filteredAreas {
            return filteredAreas
        }
        // No Filter Applied, return all the areas
        else {
            return try await AreaManager.shared.getAllArea()
        }
    }
}
