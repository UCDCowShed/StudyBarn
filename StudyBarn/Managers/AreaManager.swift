//
//  AreaManager.swift
//  StudyBarn
//
//  Created by JinLee on 2/28/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class AreaManager {
    
    static let shared = AreaManager()
    private init() {}
    
    private let areaCollection = Firestore.firestore().collection("areas")
    
    private func areaDocument(areaId: String) -> DocumentReference {
        return areaCollection.document(areaId)
    }
    
    private func setAmPm(hours: HourMin) -> String {
        let minute = hours.minute == 0 ? "00" : String(hours.minute)
        var hour = hours.hour >= 12 ? String(hours.hour == 12 ? hours.hour : hours.hour - 12) : String(hours.hour)
        let amOrPm = hours.hour >= 12 ? "PM" : "AM"
        
        // Reformat if 0 hour
        if hour == "0" {
            hour = "12"
        }
        
        return hour + ":" + minute + amOrPm
    }
    
    func formatHours (openHour: HourMin, closeHour: HourMin) -> String {
        // Check Always opened 00:00AM - 00:00AM
        if openHour.hour == 0 && closeHour.hour == 0 && openHour.minute == 0 && closeHour.minute == 0 {
            return "Always Open"
        }
        
        var formattedCloseHour = closeHour.hour
        
        if formattedCloseHour == 0 {
            formattedCloseHour = 24
        }
        
        // Check if closed (openHour and closeHour mismatch where openHour happens later than closeHours)
        if openHour.hour > formattedCloseHour {
            return "Closed"
        }
        else if openHour.hour == formattedCloseHour && openHour.minute > closeHour.minute {
            return "Closed"
        }
        
        let openHour = self.setAmPm(hours: openHour)
        let closeHour = self.setAmPm(hours: closeHour)
        
        return openHour + " - " + closeHour
    }
    
    // Determine Area opened or closed
    // Return True if opened
    func determineOpenOrClose(openHour: HourMin?, closeHour: HourMin?) -> Bool {
        guard let openHour = openHour else {return false}
        guard let closeHour = closeHour else {return false}
        
        // Check Always opened 00:00AM - 00:00AM
        if openHour.hour == 0 && closeHour.hour == 0 && openHour.minute == 0 && closeHour.minute == 0 {
            return true
        }
        
        let curTime = Utilities.shared.getCurrentTime()
        
        // Format 0AM to 24
        var formattedCloseHour = closeHour.hour
        
        if formattedCloseHour == 0 {
            formattedCloseHour = 24
        }
        
        // Before Open Hour
        if curTime.hour < openHour.hour {
            return false
        }
        // Before Open Hour: same hour but before minute
        else if curTime.hour == openHour.hour && curTime.minute <= openHour.minute {
            return false
        }
        // After Closed Hour: same hour but after the minute
        else if curTime.hour == formattedCloseHour && curTime.minute >= closeHour.minute {
            return false
        }
        // After Closed Hour
        else if curTime.hour > formattedCloseHour {
            return false
        }
        // In between Open and Close Hours
        return true
    }
    
    // Returns Document Id for creating AreaModel
    func getDocumentId() -> String {
        return areaCollection.document().documentID
    }
    
    func createNewArea(area: AreaModel) async throws {
        try areaDocument(areaId: area.areaId).setData(from: area, merge: false)
    }
    
    func getArea(areaId: String) async throws -> AreaModel? {
        let document = try? await areaDocument(areaId: areaId).getDocument()
        
        // Convert data to AreaModel format
        if document?.exists ?? false {
            return try document?.data(as: AreaModel.self)
        }
        
        return nil
    }
    
    func updateAreaFeatures(area: AreaModel) throws {
        try areaDocument(areaId: area.areaId).setData(from: area, merge: true)
    }
    
    func getAllArea() async throws -> [AreaModel] {
        let snapshot = try await areaCollection.order(by: "rating", descending: true).getDocuments()
        
        var areas: [AreaModel] = []
        
        // Convert data into AreaModel type
        for document in snapshot.documents {
            let area = try document.data(as: AreaModel.self)
            areas.append(area)
        }
        
        return areas
    }
    
    func addImage(areaId: String, name: String) async throws {
        let data: [String: Any] = [
            "images": FieldValue.arrayUnion([name])
        ]
        
        try await areaDocument(areaId: areaId).updateData(data)
    }
    
    func removeImage(areaId: String, name: String) async throws {
        let data: [String: Any] = [
            "images": FieldValue.arrayRemove([name])
        ]
        
        try await areaDocument(areaId: areaId).updateData(data)
    }
    
    // Filter By Items
    func getFilteredArea(atmosphereFilter: [FilterModel], volumeFilter: [FilterModel], featureFilter: [FilterModel]) async throws -> [AreaModel]? {
        
        var areaIds: [String] = []
        var filteredAreas: [AreaModel] = []
        
        // Get sub areas using those filters
        let subAreas = try await SubAreaManager.shared.getFilteredSubArea(atmosphereFilter: atmosphereFilter, volumeFilter: volumeFilter, featureFilter: featureFilter)
        
        // Get Areas with the areaId associated with the subareas (avoid duplicates)
        guard let subAreas = subAreas else {return nil}
        
        for subArea in subAreas {
            if !areaIds.contains(subArea.areaId) {
                areaIds.append(subArea.areaId)
                let filteredArea = try await self.getArea(areaId: subArea.areaId)
                if let filteredArea = filteredArea {
                    filteredAreas.append(filteredArea)
                }
            }
        }
        
        return filteredAreas
    }
}
