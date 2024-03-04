//
//  SubAreaManager.swift
//  StudyBarn
//
//  Created by JinLee on 2/28/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class SubAreaManager {
    
    static let shared = SubAreaManager()
    private init() {}
    
    private let subAreaCollection = Firestore.firestore().collection("subAreas")
    
    private func subAreaDocument(subAreaId: String) -> DocumentReference {
        return subAreaCollection.document(subAreaId)
    }
    
    func createNewSubArea(subArea: SubAreaModel) async throws {
        try subAreaDocument(subAreaId: subArea.subAreaId).setData(from: subArea, merge: false)
    }
    
    // Returns Document Id for creating AreaModel
    func getDocumentId() -> String {
        return subAreaCollection.document().documentID
    }
    
    func getArea(subAreaId: String) async throws -> SubAreaModel? {
        let document = try? await subAreaDocument(subAreaId: subAreaId).getDocument()
        
        // Convert data to AreaModel format
        if document?.exists ?? false {
            return try document?.data(as: SubAreaModel.self)
        }
        
        return nil
    }

}
