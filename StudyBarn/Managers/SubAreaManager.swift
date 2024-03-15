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
    
    func addSubareaImage(subareaId: String, name: String) async throws {
        let data: [String: Any] = [
            "images": FieldValue.arrayUnion([name])
        ]
        
        try await subAreaDocument(subAreaId: subareaId).updateData(data)
    }
    
    // get all subareas from area id
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
    
    func getAllFavoriteSubAreas(subAreaIds: [String]) async throws -> [SubAreaModel] {
        var favoriteSubAreas: [SubAreaModel] = []
        
        for subAreaId in subAreaIds {
            let subArea = try await self.getArea(subAreaId: subAreaId)
            if let subArea = subArea {
                favoriteSubAreas.append(subArea)
            }
        }
        
        return favoriteSubAreas
    }
    
    // Get Subarea with a feature
    func getSubAreaByFeature(feature: String) async throws -> [SubAreaModel] {
        var subAreas: [SubAreaModel] = []
        
        let query = subAreaCollection
            .whereField(feature, isEqualTo: true)
        
        let snapshot = try await query.getDocuments()
        
        // Convert data into AreaModel type
        for document in snapshot.documents {
            let subArea = try document.data(as: SubAreaModel.self)
            subAreas.append(subArea)
        }
        
        var randomThree: [SubAreaModel] = []
        
        for _ in 0..<3 {
            if subAreas.count == 0 {
                break
            }
            let randomNumber = Int.random(in: 0...subAreas.count-1)
            let removedItem = subAreas.remove(at: randomNumber)

            if !randomThree.contains(removedItem) {
                randomThree.append(removedItem)
            }
        }

        return randomThree
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
