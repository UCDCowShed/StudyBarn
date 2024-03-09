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
    
    func addNewSubArea(subAreaName: String, areaId: String, floor: Int, outdoors: Bool, groupStudy: Bool, microwave: Bool, printer: Bool, dining: Bool, outlets: Bool, computers: Bool, areaModel: AreaModel?) async throws {
        
        // Initialize area values
        let subAreaId = SubAreaManager.shared.getDocumentId()
        let rating = 0.0
        let images: [String]? = []
        
        let subArea = SubAreaModel(subAreaId: subAreaId, name: subAreaName, areaId: areaId, floor: floor, images: images, outdoors: outdoors, groupStudy: groupStudy, microwave: microwave, printer: printer, dining: dining, outlets: outlets, computers: computers, rating: rating)
        
        // Modify Area with the new features
        if var areaModel = areaModel {
            if let areaHasFeature = areaModel.outdoors {
                if areaHasFeature || outdoors {
                    areaModel.outdoors = true
                }
            } else {
                areaModel.outdoors = outdoors
            }
            if let areaHasFeature = areaModel.indoors {
                if areaHasFeature || !outdoors {
                    areaModel.indoors = true
                }
            } else {
                areaModel.indoors = !outdoors
            }
            if let areaHasFeature = areaModel.quietStudy {
                if areaHasFeature || !groupStudy {
                    areaModel.quietStudy = true
                }
            } else {
                areaModel.quietStudy = !groupStudy
            }
            if let areaHasFeature = areaModel.groupStudy {
                if areaHasFeature || groupStudy {
                    areaModel.groupStudy = true
                }
            } else {
                areaModel.groupStudy = groupStudy
            }
            if let areaHasFeature = areaModel.microwave {
                if areaHasFeature || microwave {
                    areaModel.microwave = true
                }
            } else {
                areaModel.microwave = microwave
            }
            if let areaHasFeature = areaModel.printer {
                if areaHasFeature || printer {
                    areaModel.printer = true
                }
            } else {
                areaModel.printer = printer
            }
            if let areaHasFeature = areaModel.dining {
                if areaHasFeature || dining {
                    areaModel.dining = true
                }
            } else {
                areaModel.dining = dining
            }
            if let areaHasFeature = areaModel.outlets {
                if areaHasFeature || outlets {
                    areaModel.outlets = true
                }
            } else {
                areaModel.outlets = outlets
            }
            if let areaHasFeature = areaModel.computers {
                if areaHasFeature || computers {
                    areaModel.computers = true
                }
            } else {
                areaModel.computers = computers
            }
            // Create SubArea
            try await SubAreaManager.shared.createNewSubArea(subArea: subArea, area: areaModel)
        }
        
        
        
    }
    
}
