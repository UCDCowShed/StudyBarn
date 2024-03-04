//
//  DetailsViewModel.swift
//  StudyBarn
//
//  Created by JinLee on 3/4/24.
//

import Foundation

@MainActor
final class DetailsViewModel: ObservableObject {
    @Published var subAreas: [SubAreaModel]? = []
    
    func loadAllSubAreaFromArea(areaId: String) async throws -> [SubAreaModel]?{
        let allSubArea = try await SubAreaManager.shared.getAllSubAreaFromAreaId(areaId: areaId)
        
        return allSubArea
    }
}
