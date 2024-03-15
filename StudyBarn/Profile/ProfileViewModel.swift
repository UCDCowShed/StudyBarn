//
//  ProfileViewModel.swift
//  StudyBarn
//
//  Created by JinLee on 3/14/24.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    
    func loadRecommendedAreas(userId: String?) async throws -> [SubAreaModel] {
        
        guard let userId = userId else {
            print("User Not Found...")
            return []
        }
        
        // Get Random feature from area
        let mostVisitedArea = try await MapManager.shared.getMostVisitedArea(userId: userId)
        
        let outdoors = mostVisitedArea?.outdoors ?? false
        let indoors = mostVisitedArea?.indoors ?? false
        let computers = mostVisitedArea?.computers ?? false
        let printer = mostVisitedArea?.printer ?? false
        let groupStudy = mostVisitedArea?.groupStudy ?? false
        let quietStudy = mostVisitedArea?.quietStudy ?? false
        let dining = mostVisitedArea?.dining ?? false
        let outlets = mostVisitedArea?.outlets ?? false
        let microwave = mostVisitedArea?.microwave ?? false
        
        let rawFeatures = [
            AreaModel.CodingKeys.outdoors.rawValue:outdoors,
            AreaModel.CodingKeys.indoors.rawValue:indoors,
            AreaModel.CodingKeys.computers.rawValue:computers,
            AreaModel.CodingKeys.printer.rawValue:printer,
            AreaModel.CodingKeys.groupStudy.rawValue:groupStudy,
            AreaModel.CodingKeys.quietStudy.rawValue:quietStudy,
            AreaModel.CodingKeys.dining.rawValue:dining,
            AreaModel.CodingKeys.microwave.rawValue:microwave,
            AreaModel.CodingKeys.outlets.rawValue:outlets
        ]
        
        var selectedFeatures: [String] = []
        
        // Extract True Values
        for feature in rawFeatures.keys {
            if rawFeatures[feature] ?? false {
                selectedFeatures.append(feature)
            }
        }
        
        if selectedFeatures.count == 0 {
            print("Nothing Found")
            return []
        }
        
        let randomFeature = selectedFeatures.randomElement()
        
        guard let randomFeature = randomFeature else { return [] }
        
        // Get Recommended SubAreas using the random feature
        let recommendedAreas = try await SubAreaManager.shared.getSubAreaByFeature(feature: randomFeature)
        
        return recommendedAreas
    }
}
