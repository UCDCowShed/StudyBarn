//
//  AddSubAreaViewModel.swift
//  StudyBarn
//
//  Created by JinLee on 2/28/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

// ONLY FOR ADMINS

@MainActor
final class AddSubAreaViewModel: ObservableObject {
    
    func addNewSubArea(subAreaName: String, areaId: String, floor: Int, outdoors: Bool, groupStudy: Bool, microwave: Bool, printer: Bool, dining: Bool, outlets: Bool, computers: Bool, bougie: Bool, lecture: Bool, independent: Bool, bustling: Bool, grassy: Bool, areaModel: AreaModel?) async throws {
        
        // Initialize area values
        let subAreaId = SubAreaManager.shared.getDocumentId()
        let rating = 0.0
        let images: [String]? = []
        
        let subArea = SubAreaModel(subAreaId: subAreaId, name: subAreaName, areaId: areaId, floor: floor, images: images, outdoors: outdoors, groupStudy: groupStudy, microwave: microwave, printer: printer, dining: dining, outlets: outlets, computers: computers, bougie: bougie, lecture: lecture, independent: independent, bustling: bustling, grassy: grassy, rating: rating)
        
        // Modify existing Area with the new features
        if var area = areaModel {
            
            // if the area has an outdoor parameter
            if let areaHasFeature = area.outdoors {
                // if the area already has outdoors, check if it is false or true, if true, area should be true
                if areaHasFeature || outdoors {
                    area.outdoors = true
                }
            // if the area does not have an outdoor parameter, then the parameter should be set
            } else {
                area.outdoors = outdoors
            }
            if let areaHasFeature = area.indoors {
                if areaHasFeature || !outdoors {
                    area.indoors = true
                }
            } else {
                area.indoors = !outdoors
            }
            if let areaHasFeature = area.quietStudy {
                if areaHasFeature || !groupStudy {
                    area.quietStudy = true
                }
            } else {
                area.quietStudy = !groupStudy
            }
            if let areaHasFeature = area.groupStudy {
                if areaHasFeature || groupStudy {
                    area.groupStudy = true
                }
            } else {
                area.groupStudy = groupStudy
            }
            if let areaHasFeature = area.microwave {
                if areaHasFeature || microwave {
                    area.microwave = true
                }
            } else {
                area.microwave = microwave
            }
            if let areaHasFeature = area.printer {
                if areaHasFeature || printer {
                    area.printer = true
                }
            } else {
                area.printer = printer
            }
            if let areaHasFeature = area.dining {
                if areaHasFeature || dining {
                    area.dining = true
                }
            } else {
                area.dining = dining
            }
            if let areaHasFeature = area.outlets {
                if areaHasFeature || outlets {
                    area.outlets = true
                }
            } else {
                area.outlets = outlets
            }
            if let areaHasFeature = area.computers {
                if areaHasFeature || computers {
                    area.computers = true
                }
            } else {
                area.computers = computers
            }
            // Create SubArea
            try await SubAreaManager.shared.createNewSubArea(subArea: subArea, area: area)
            
        }       
    }
    
}
