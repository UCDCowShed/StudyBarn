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
        FilterModel(id: 0, name: "Outdoors", selected: false),
        FilterModel(id: 1, name: "Indoors", selected: false),
        FilterModel(id: 2, name: "Bustling Atmosphere", selected: false),
        FilterModel(id: 3, name: "Quiet Atmosphere", selected: false)
    ]
    
    @Published var volumeFilter = [
        FilterModel(id: 0, name: "Group Study", selected: false),
        FilterModel(id: 1, name: "Quiet Study", selected: false),
        FilterModel(id: 2, name: "Silent Study", selected: false)
    ]
    
    @Published var featureFilter = [
        FilterModel(id: 0, name: "Microwave", selected: false),
        FilterModel(id: 1, name: "Printing", selected: false),
        FilterModel(id: 2, name: "Outlets", selected: false),
        FilterModel(id: 3, name: "Food vendor", selected: false),
        FilterModel(id: 4, name: "Computers", selected: false),
        FilterModel(id: 5, name: "Relaxing", selected: false)
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
    
}
