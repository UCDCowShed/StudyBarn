//
//  StorageManager.swift
//  StudyBarn
//
//  Created by Ann Yip on 3/5/24.
//

import SwiftUI
import FirebaseStorage

final class ImageManager {
    
    static let shared = ImageManager()
    private init() { }
    
    private let storage = Storage.storage().reference()
    
    private func areaReference(areaID: String, isArea: Bool) -> StorageReference {
        storage.child(isArea ? "areas" : "subareas").child(areaID)
    }
    
    func saveImage(data: Data, areaID: String, isArea: Bool) async throws -> String {
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        
        let path = "\(UUID().uuidString).jpeg"
        let returnedMetaData = try await areaReference(areaID: areaID, isArea: isArea).child(path).putDataAsync(data, metadata: meta)
        
        guard let returnedName = returnedMetaData.name else {
            throw URLError(.badServerResponse)
        }
        return returnedName
    }
    
    func getImageURL(areaID: String, path: String, isArea: Bool) async throws -> URL {
        try await areaReference(areaID: areaID, isArea: isArea).child(path).downloadURL()
    }
    
    func getAllImages(areaID: String, images: [String], isArea: Bool) async throws -> [URL]? {
        var urls: [URL] = []
        for image in images {
            try await urls.append(getImageURL(areaID: areaID, path: image, isArea: isArea))
        }
        return urls
    }
}
