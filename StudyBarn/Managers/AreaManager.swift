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
    
    func formatHours (hours: HourMin?) -> String {
        guard let hours = hours else { return "00:00"}
        
        // Set Minute
        let minute = hours.minute == 0 ? "00" : String(hours.minute)
        
        // PM
        if hours.hour > 12 {
            let formatHour = hours.hour - 12
            return "\(formatHour):\(minute) PM"
        }
        // 12 PM
        else if hours.hour == 12 {
            return "\(hours.hour):\(minute) PM"
        }
        // AM
        else {
            return "\(hours.hour):\(minute) AM"
        }
        
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
    
    func getAllArea() async throws -> [AreaModel] {
        let snapshot = try await areaCollection.getDocuments()
        
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

}
