//
//  UserAreaTrackedModel.swift
//  StudyBarn
//
//  Created by JinLee on 3/11/24.
//

import Foundation

struct AreaTrack: Codable, Hashable {
    let count: Int
    let dateModified: Date
}

struct UserAreaTrackedModel: Codable, Hashable {
    let userId: String
    let areaTracked: [String: AreaTrack]
    
    enum CodingKeys: String, CodingKey {
        case userId
        case areaTracked
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.areaTracked = try container.decode([String : AreaTrack].self, forKey: .areaTracked)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encode(self.areaTracked, forKey: .areaTracked)
    }

}
