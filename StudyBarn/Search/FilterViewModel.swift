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
        FilterModel(id: 0, name: "outdoors", selected: false),
    ]
    
    @Published var volumeFilter = [
        FilterModel(id: 0, name: "groupStudy", selected: false),
    ]
    
    @Published var featureFilter = [
        FilterModel(id: 0, name: "microwave", selected: false),
        FilterModel(id: 1, name: "printing", selected: false),
        FilterModel(id: 2, name: "outlets", selected: false),
        FilterModel(id: 3, name: "computers", selected: false),
        FilterModel(id: 4, name: "food", selected: false),
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
    func getFilteredAreas() {
        // send atmosphereFilter, volumeFilter, and featureFilter to the AreaManager
    }
}
