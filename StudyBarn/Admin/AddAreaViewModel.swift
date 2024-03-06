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
    private func formattedHours(hours: Date) -> HourMin {
        let hour = Calendar.current.component(.hour, from: hours)
        let minute = Calendar.current.component(.minute, from: hours)
        return HourMin(hour: hour, minute: minute)
    }
    
    func addNewArea(areaName: String, openHour: Date, closeHour: Date, latitude: String, longitude: String) async throws {
        
        // Initialize area values
        let areaId = AreaManager.shared.getDocumentId()
        let openHourFormatted = formattedHours(hours: openHour)
        let closeHourFormatted = formattedHours(hours: closeHour)
        let rating = 0.0
        let images: [DocumentReference]? = []
        
        // Convert to Double Values
        let numLatitude = latitude.doubleValue
        let numLongitude = longitude.doubleValue
        let area = AreaModel(areaId: areaId, name: areaName, rating: rating, images: images, openHour: openHourFormatted, closeHour: closeHourFormatted, latitude: numLatitude, longitude: numLongitude)
        
        try await AreaManager.shared.createNewArea(area: area)
    }
    
}
