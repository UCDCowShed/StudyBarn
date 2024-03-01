//
//  UserModel.swift
//  StudyBarn
//
//  Created by JinLee on 2/27/24.
//

import Foundation

struct UserModel: Codable {
    let userId: String
    let email: String?
    let name: String?
    let photoUrl: String?
    let dateCreated: Date?
    let favorites: [String]
    let admin: Bool?
    
    // Initialize User from the Result of Google Sign In
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.name = auth.name
        self.email = auth.email
        self.photoUrl = auth.photoUrl
        self.dateCreated = Date()
        self.favorites = []
        self.admin = false
    }
    
    // ENCODER & DECODER
    enum CodingKeys: String, CodingKey {
        case userId
        case email
        case name
        case photoUrl
        case dateCreated
        case favorites
        case admin
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.photoUrl = try container.decodeIfPresent(String.self, forKey: .photoUrl)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        self.favorites = try container.decode([String].self, forKey: .favorites)
        self.admin = try container.decodeIfPresent(Bool.self, forKey: .admin)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.photoUrl, forKey: .photoUrl)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
        try container.encode(self.favorites, forKey: .favorites)
        try container.encodeIfPresent(self.admin, forKey: .admin)
    }
}


