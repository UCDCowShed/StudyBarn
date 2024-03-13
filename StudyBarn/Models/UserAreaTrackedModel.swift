//
//  UserAreaTrackedModel.swift
//  StudyBarn
//
//  Created by JinLee on 3/11/24.
//

import Foundation

struct AreaTrackModel: Codable, Hashable {
    let count: Int
    let dateModified: Date
}

struct UserAreaTrackedModel: Codable, Hashable {
    let userId: String
    let areaTracked: [String: AreaTrackModel]
    
    init(
        userId: String,
        areaTracked: [String: AreaTrackModel]
    ) {
        self.userId = userId
        self.areaTracked = areaTracked
    }
    
    enum CodingKeys: CodingKey {
        case userId
        case areaTracked
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.areaTracked = try container.decode([String : AreaTrackModel].self, forKey: .areaTracked)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encode(self.areaTracked, forKey: .areaTracked)
    }
    

}
