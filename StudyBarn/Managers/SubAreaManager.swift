//
//  SubAreaManager.swift
//  StudyBarn
//
//  Created by JinLee on 2/28/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class SubAreaManager {
    
    static let shared = SubAreaManager()
    private init() {}
    
    private let subAreaCollection = Firestore.firestore().collection("subAreas")
    
    private func subAreaDocument(subAreaId: String) -> DocumentReference {
        return subAreaCollection.document(subAreaId)
    }
    
    func createNewSubArea(subArea: SubAreaModel, area: AreaModel) async throws {
        // Create new SubArea
        try subAreaDocument(subAreaId: subArea.subAreaId).setData(from: subArea, merge: false)
        // Modify Area with new features
        try AreaManager.shared.updateAreaFeatures(area: area)
    }
    
    // Returns Document Id for creating AreaModel
    func getDocumentId() -> String {
        return subAreaCollection.document().documentID
    }
    
    func getArea(subAreaId: String) async throws -> SubAreaModel? {
        let document = try? await subAreaDocument(subAreaId: subAreaId).getDocument()
        
        // Convert data to AreaModel format
        if document?.exists ?? false {
            return try document?.data(as: SubAreaModel.self)
        }
        
        return nil
    }
    
    func getAllSubAreaFromAreaId(areaId: String) async throws -> [SubAreaModel] {
        let snapshot = try await subAreaCollection.whereField(SubAreaModel.CodingKeys.areaId.rawValue, isEqualTo: areaId).getDocuments()
        
        var subAreas: [SubAreaModel] = []
        
        // Convert data into AreaModel type
        for document in snapshot.documents {
            let subArea = try document.data(as: SubAreaModel.self)
            subAreas.append(subArea)
        }
        
        return subAreas
    }

    // Get Filtered subAreas
    func getFilteredSubArea(atmosphereFilter: [FilterModel], volumeFilter: [FilterModel], featureFilter: [FilterModel]) async throws -> [SubAreaModel]? {
        
        // Query by the filtered items
        var query = subAreaCollection as Query
        var noQuery = true
        
        // Update Query Values from atmosphere Filter
        for atmos in atmosphereFilter {
            if atmos.selected {
                query = query.whereField(atmos.name, isEqualTo: true)
                noQuery = false
            }
        }
        
        // Update Query Values from volume Filter
        for volume in volumeFilter {
            if volume.selected {
                query = query.whereField(volume.name, isEqualTo: true)
                noQuery = false
            }
        }
        
        // Update Query Values from Feature filter
        for feature in featureFilter {
            if feature.selected {
                query = query.whereField(feature.name, isEqualTo: true)
                noQuery = false
            }
        }
        
        // No Filter Given
        if noQuery {
            return nil
        }
        
        let snapshot = try await query.getDocuments()
        
        var subAreas: [SubAreaModel] = []
        
        // Convert data into AreaModel type
        for document in snapshot.documents {
            let subArea = try document.data(as: SubAreaModel.self)
            subAreas.append(subArea)
        }

        return subAreas
    }
}
