//
//  SubAreaModel.swift
//  StudyBarn
//
//  Created by JinLee on 2/28/24.
//

import Foundation

struct SubAreaModel: Codable, Hashable {
    let subAreaId: String
    let name: String
    let areaId: String
    let floor: Int?
    let images: [String]?
    let outdoors: Bool?
    let groupStudy: Bool?
    let microwave: Bool?
    let printer: Bool?
    let food: Bool?
    let outlets: Bool?
    let rating: Double?
    
    init(
        subAreaId: String,
        name: String,
        areaId: String,
        floor: Int?,
        images: [String]?,
        outdoors: Bool?,
        groupStudy: Bool?,
        microwave: Bool?,
        printer: Bool?,
        food: Bool?,
        outlets: Bool?,
        rating: Double?
    ) {
        self.subAreaId = subAreaId
        self.name = name
        self.areaId = areaId
        self.floor = floor
        self.images = images
        self.outdoors = outdoors
        self.groupStudy = groupStudy
        self.microwave = microwave
        self.printer = printer
        self.food = food
        self.outlets = outlets
        self.rating = rating
    }
    
    enum CodingKeys: String, CodingKey {
        case subAreaId
        case name
        case areaId
        case floor
        case images
        case outdoors
        case groupStudy
        case microwave
        case printer
        case food
        case outlets
        case rating
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.subAreaId = try container.decode(String.self, forKey: .subAreaId)
        self.name = try container.decode(String.self, forKey: .name)
        self.areaId = try container.decode(String.self, forKey: .areaId)
        self.floor = try container.decodeIfPresent(Int.self, forKey: .floor)
        self.images = try container.decodeIfPresent([String].self, forKey: .images)
        self.outdoors = try container.decodeIfPresent(Bool.self, forKey: .outdoors)
        self.groupStudy = try container.decodeIfPresent(Bool.self, forKey: .groupStudy)
        self.microwave = try container.decodeIfPresent(Bool.self, forKey: .microwave)
        self.printer = try container.decodeIfPresent(Bool.self, forKey: .printer)
        self.food = try container.decodeIfPresent(Bool.self, forKey: .food)
        self.outlets = try container.decodeIfPresent(Bool.self, forKey: .outlets)
        self.rating = try container.decodeIfPresent(Double.self, forKey: .rating)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.subAreaId, forKey: .subAreaId)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.areaId, forKey: .areaId)
        try container.encodeIfPresent(self.floor, forKey: .floor)
        try container.encodeIfPresent(self.images, forKey: .images)
        try container.encodeIfPresent(self.outdoors, forKey: .outdoors)
        try container.encodeIfPresent(self.groupStudy, forKey: .groupStudy)
        try container.encodeIfPresent(self.microwave, forKey: .microwave)
        try container.encodeIfPresent(self.printer, forKey: .printer)
        try container.encodeIfPresent(self.food, forKey: .food)
        try container.encodeIfPresent(self.outlets, forKey: .outlets)
        try container.encodeIfPresent(self.rating, forKey: .rating)
    }
}
