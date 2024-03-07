//
//  AddSubAreaViewModel.swift
//  StudyBarn
//
//  Created by JinLee on 2/28/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

@MainActor
final class AddSubAreaViewModel: ObservableObject {
    
    func addNewSubArea(subAreaName: String, areaId: String, floor: Int, outdoors: Bool, groupStudy: Bool, microwave: Bool, printer: Bool, dining: Bool, outlets: Bool, computers: Bool) async throws {
        
        // Initialize area values
        let subAreaId = SubAreaManager.shared.getDocumentId()
        let rating = 0.0
        let images: [String]? = []
        
        let subArea = SubAreaModel(subAreaId: subAreaId, name: subAreaName, areaId: areaId, floor: floor, images: images, outdoors: outdoors, groupStudy: groupStudy, microwave: microwave, printer: printer, dining: dining, outlets: outlets, computers: computers, rating: rating)
        
        // Create SubArea
        try await SubAreaManager.shared.createNewSubArea(subArea: subArea)
    }
    
}
