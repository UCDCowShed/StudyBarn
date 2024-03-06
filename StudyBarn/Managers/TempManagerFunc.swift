////
////  TempManagerFunc.swift
////  StudyBarn
////
////  Created by JinLee on 3/6/24.
////
//
//import Foundation
//
//// Get Filtered subAreas
//func getFilteredSubArea(atmosphereFilter: [FilterModel], volumeFilter: [FilterModel], featureFilter: [FilterModel]) async throws -> [SubAreaModel]{
//    
//    // Query by the filtered items
//    var query = subAreaCollection
//        .whereField(SubAreaModel.CodingKeys.outdoors.rawValue, isEqualTo: atmosphereFilter[0].selected)
//        .whereField(SubAreaModel.CodingKeys.groupStudy.rawValue, isEqualTo: volumeFilter[0].selected)
//    
//    // Update Query Values
//    for feature in featureFilter {
//        if feature.selected {
//            query = query.whereField(feature.name, isEqualTo: 1)
//        }
//    }
//    
//    let snapshot = try await query.getDocuments()
//    
//    var subAreas: [SubAreaModel] = []
//    
//    // Convert data into AreaModel type
//    for document in snapshot.documents {
//        let subArea = try document.data(as: SubAreaModel.self)
//        subAreas.append(subArea)
//    }
//    
//    return subAreas
//}
//
//
//// Filter By Items
//func getFilteredArea(atmosphereFilter: [FilterModel], volumeFilter: [FilterModel], featureFilter: [FilterModel]) async throws {
//    // Get atmosphereFilter, volumeFilter, and featureFilter from the FilterViewModel
//    
//    // Get sub areas first using those filters
//    
//    // Get Areas with the areaId associated with the subareas
//    
//}
