//
//  AddAreaViewModel.swift
//  StudyBarn
//
//  Created by JinLee on 2/28/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

@MainActor
final class AddAreaViewModel: ObservableObject {
    
    // Change Time to HourMin
    private func formattedHours(hours: Date?) -> HourMin? {
        if let hours = hours {
            let hour = Calendar.current.component(.hour, from: hours)
            let minute = Calendar.current.component(.minute, from: hours)
            return HourMin(hour: hour, minute: minute)
        }
        return nil
    }
    
    // Create Week HourMin
    private func formatWeekHours(hours: [Int: Date?]) -> [Int: HourMin?] {
        var formattedHours: [Int: HourMin] = [:]
        for hour in Array(hours.keys) {
            if let date = hours[hour] {
                formattedHours[hour] = self.formattedHours(hours: date)
            }
            else {
                formattedHours[hour] = nil
            }
        }
        return formattedHours
    }
    
    func addNewArea(areaName: String, openHours: [Int: Date?], closeHours: [Int: Date?], latitude: String, longitude: String) async throws {
        // Initialize area values
        let areaId = AreaManager.shared.getDocumentId()
        let openHourFormatted = formatWeekHours(hours: openHours)
        let closeHourFormatted = formatWeekHours(hours: closeHours)
        let rating = 0.0
        let images: [String]? = []
        
        // Convert to Double Values
        let numLatitude = latitude.doubleValue
        let numLongitude = longitude.doubleValue
        let area = AreaModel(areaId: areaId, name: areaName, rating: rating, images: images, openHour: openHourFormatted, closeHour: closeHourFormatted, latitude: numLatitude, longitude: numLongitude)
        
        try await AreaManager.shared.createNewArea(area: area)
    }
    
}
