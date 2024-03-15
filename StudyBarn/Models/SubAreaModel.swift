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
    let dining: Bool?
    let outlets: Bool?
    let computers: Bool?
    let bougie: Bool?
    let lecture: Bool?
    let independent: Bool?
    let bustling: Bool?
    let grassy: Bool?
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
        dining: Bool?,
        outlets: Bool?,
        computers: Bool?,
        bougie: Bool?,
        lecture: Bool?,
        independent: Bool?,
        bustling: Bool?,
        grassy: Bool?,
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
        self.dining = dining
        self.outlets = outlets
        self.computers = computers
        self.bougie = bougie
        self.lecture = lecture
        self.independent = independent
        self.bustling = bustling
        self.grassy = grassy
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
        case dining
        case outlets
        case computers
        case bougie
        case lecture
        case independent
        case bustling
        case grassy
        case rating
    }
    
    
    init(from decoder: any Decoder) throws {
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
        self.dining = try container.decodeIfPresent(Bool.self, forKey: .dining)
        self.outlets = try container.decodeIfPresent(Bool.self, forKey: .outlets)
        self.computers = try container.decodeIfPresent(Bool.self, forKey: .computers)
        self.bougie = try container.decodeIfPresent(Bool.self, forKey: .bougie)
        self.lecture = try container.decodeIfPresent(Bool.self, forKey: .lecture)
        self.independent = try container.decodeIfPresent(Bool.self, forKey: .independent)
        self.bustling = try container.decodeIfPresent(Bool.self, forKey: .bustling)
        self.grassy = try container.decodeIfPresent(Bool.self, forKey: .grassy)
        self.rating = try container.decodeIfPresent(Double.self, forKey: .rating)
    }
    
    func encode(to encoder: any Encoder) throws {
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
        try container.encodeIfPresent(self.dining, forKey: .dining)
        try container.encodeIfPresent(self.outlets, forKey: .outlets)
        try container.encodeIfPresent(self.computers, forKey: .computers)
        try container.encodeIfPresent(self.bougie, forKey: .bougie)
        try container.encodeIfPresent(self.lecture, forKey: .lecture)
        try container.encodeIfPresent(self.independent, forKey: .independent)
        try container.encodeIfPresent(self.bustling, forKey: .bustling)
        try container.encodeIfPresent(self.grassy, forKey: .grassy)
        try container.encodeIfPresent(self.rating, forKey: .rating)
    }
}
