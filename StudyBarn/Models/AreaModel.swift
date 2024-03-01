//
//  AreaModel.swift
//  StudyBarn
//
//  Created by JinLee on 2/28/24.
//

import Foundation

struct HourMin: Codable {
    let hour: Int
    let minute: Int
}

struct AreaModel: Codable {
    let areaId: String
    let name: String
    let rating: Int?
    let images: [String]?
    let openHour: HourMin?
    let closeHour: HourMin?
    let latitude: Double?
    let longitude: Double?
    
    init(areaId: String, name: String, rating: Int?, images: [String]?, openHour: HourMin?, closeHour: HourMin?, latitude: Double?, longitude: Double?) {
        self.areaId = areaId
        self.name = name
        self.rating = rating
        self.images = images ?? []
        self.openHour = openHour
        self.closeHour = closeHour
        self.latitude = latitude
        self.longitude = longitude
    }
    
    enum CodingKeys: String, CodingKey {
        case areaId
        case name
        case rating
        case images
        case openHour
        case closeHour
        case latitude
        case longitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.areaId = try container.decode(String.self, forKey: .areaId)
        self.name = try container.decode(String.self, forKey: .name)
        self.rating = try container.decodeIfPresent(Int.self, forKey: .rating)
        self.images = try container.decodeIfPresent([String].self, forKey: .images)
        self.openHour = try container.decodeIfPresent(HourMin.self, forKey: .openHour)
        self.closeHour = try container.decodeIfPresent(HourMin.self, forKey: .closeHour)
        self.latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
        self.longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.areaId, forKey: .areaId)
        try container.encode(self.name, forKey: .name)
        try container.encodeIfPresent(self.rating, forKey: .rating)
        try container.encodeIfPresent(self.images, forKey: .images)
        try container.encodeIfPresent(self.openHour, forKey: .openHour)
        try container.encodeIfPresent(self.closeHour, forKey: .closeHour)
        try container.encodeIfPresent(self.latitude, forKey: .latitude)
        try container.encodeIfPresent(self.longitude, forKey: .longitude)
    }
    
}
