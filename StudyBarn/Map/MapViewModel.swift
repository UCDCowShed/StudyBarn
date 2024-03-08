//
//  MapViewModel.swift
//  StudyBarn
//
//  Created by JinLee on 3/7/24.
//

import Foundation

@MainActor
final class MapViewModel: ObservableObject {
    @Published var areas: [AreaModel]? = []
    
    func loadAllArea() async throws -> [AreaModel]?{
        let allArea = try await AreaManager.shared.getAllArea()
        
        return allArea
    }
    
    
}
