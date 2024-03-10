//
//  AreaModel.swift
//  StudyBarn
//
//  Created by JinLee on 2/28/24.
//

import Foundation

struct HourMin: Codable, Hashable {
    let hour: Int
    let minute: Int
}

struct AreaModel: Codable, Hashable {
    
    let areaId: String
    let name: String
    let rating: Double?
    let images: [String]?
    let openHour: [String: HourMin]
    let closeHour: [String: HourMin]
    let latitude: Double?
    let longitude: Double?
    var outdoors: Bool?
    var indoors: Bool?
    var groupStudy: Bool?
    var quietStudy: Bool?
    var microwave: Bool?
    var printer: Bool?
    var dining: Bool?
    var outlets: Bool?
    var computers: Bool?
    
    init(areaId: String, name: String, rating: Double?, images: [String]?, openHour: [String: HourMin], closeHour: [String: HourMin], latitude: Double?, longitude: Double?) {
        self.areaId = areaId
        self.name = name
        self.rating = rating
        self.images = images ?? []
        self.openHour = openHour
        self.closeHour = closeHour
        self.latitude = latitude
        self.longitude = longitude
        self.outdoors = nil
        self.indoors = nil
        self.quietStudy = nil
        self.groupStudy = nil
        self.microwave = nil
        self.printer = nil
        self.dining = nil
        self.outlets = nil
        self.computers = nil
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
        case outdoors
        case indoors
        case groupStudy
        case quietStudy
        case microwave
        case printer
        case dining
        case outlets
        case computers
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.areaId = try container.decode(String.self, forKey: .areaId)
        self.name = try container.decode(String.self, forKey: .name)
        self.rating = try container.decodeIfPresent(Double.self, forKey: .rating)
        self.images = try container.decodeIfPresent([String].self, forKey: .images)
        self.openHour = try container.decode([String : HourMin].self, forKey: .openHour)
        self.closeHour = try container.decode([String : HourMin].self, forKey: .closeHour)
        self.latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
        self.longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
        self.outdoors = try container.decodeIfPresent(Bool.self, forKey: .outdoors)
        self.indoors = try container.decodeIfPresent(Bool.self, forKey: .indoors)
        self.groupStudy = try container.decodeIfPresent(Bool.self, forKey: .groupStudy)
        self.quietStudy = try container.decodeIfPresent(Bool.self, forKey: .quietStudy)
        self.microwave = try container.decodeIfPresent(Bool.self, forKey: .microwave)
        self.printer = try container.decodeIfPresent(Bool.self, forKey: .printer)
        self.dining = try container.decodeIfPresent(Bool.self, forKey: .dining)
        self.outlets = try container.decodeIfPresent(Bool.self, forKey: .outlets)
        self.computers = try container.decodeIfPresent(Bool.self, forKey: .computers)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.areaId, forKey: .areaId)
        try container.encode(self.name, forKey: .name)
        try container.encodeIfPresent(self.rating, forKey: .rating)
        try container.encodeIfPresent(self.images, forKey: .images)
        try container.encode(self.openHour, forKey: .openHour)
        try container.encode(self.closeHour, forKey: .closeHour)
        try container.encodeIfPresent(self.latitude, forKey: .latitude)
        try container.encodeIfPresent(self.longitude, forKey: .longitude)
        try container.encodeIfPresent(self.outdoors, forKey: .outdoors)
        try container.encodeIfPresent(self.indoors, forKey: .indoors)
        try container.encodeIfPresent(self.groupStudy, forKey: .groupStudy)
        try container.encodeIfPresent(self.quietStudy, forKey: .quietStudy)
        try container.encodeIfPresent(self.microwave, forKey: .microwave)
        try container.encodeIfPresent(self.printer, forKey: .printer)
        try container.encodeIfPresent(self.dining, forKey: .dining)
        try container.encodeIfPresent(self.outlets, forKey: .outlets)
        try container.encodeIfPresent(self.computers, forKey: .computers)
    }
    
}
