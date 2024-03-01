//
//  ExploreViewModel.swift
//  StudyBarn
//
//  Created by JinLee on 2/29/24.
//

import Foundation

@MainActor
final class ExploreViewModel: ObservableObject {
    @Published var areas: [AreaModel]? = []
    
    func loadAllArea() async throws -> [AreaModel]?{
        let allArea = try await AreaManager.shared.getAllArea()
        
        return allArea
    }
    
    
}
