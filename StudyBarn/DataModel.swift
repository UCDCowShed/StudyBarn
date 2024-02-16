//
//  locationModel.swift
//  StudyBarn
//
//  Created by JinLee on 2/15/24.
//

import Foundation

enum Capacity {
    case empty
    case average
    case full
}

struct User {
    let userId: String
    let name: String
    let authToken: String
    
    var favoriteLocations: [Location]
}


struct Location: Identifiable {
    let id: UUID
    let name: String
    let address: String
    // Rooms within the location
//    let rooms: [Room]?
    
    // Edit Works
    var capacity: Capacity
    var rating: Int
    var openHours: String
    var closeHours: String
    var images: String
    
    // add rating
    mutating func addRating (rating: Int) {
        // api request to update the rating of the location
        self.rating = rating
    }
    
    // edit capacity
    mutating func editCapacity (capacity: Capacity) {
        // api request to edit capacity of the location
        self.capacity = capacity
    }
}

class DataModel: ObservableObject {
    var location1: Location = Location(id: UUID(), name: "Location1", address: "1 location Address", capacity: .empty, rating: 2, openHours: "6am", closeHours: "8pm", images: "location1Image")
    var location2: Location = Location(id: UUID(), name: "Location2", address: "2 location Address", capacity: .empty, rating: 4, openHours: "6am", closeHours: "8pm", images: "location2Image")
    var location3: Location = Location(id: UUID(), name: "Location3", address: "3 location Address", capacity: .empty, rating: 5, openHours: "6am", closeHours: "8pm", images: "location3Image")
    
    @Published var user: User?
    @Published var locations: [Location]
    
    init () {
        locations = [self.location1, self.location2, self.location2]
    }
    
    // get location
    func getLocation (locationId: UUID) -> Location? {
        // find location
        for location in locations {
            if location.id == locationId {
                return location
            }
        }
        
        return nil
    }
    
    // adding new location
    func addLocation (location: Location) {
        locations.append(location)
    }
    
    // add favorite location
    func addFavoriteLocation (locationId: UUID) -> Bool {
        // get location from locationModel
        let newFavoriteLocation = getLocation(locationId: locationId)
        
        // should throw error
        guard let newFavoriteLocation = newFavoriteLocation else {
            return false
        }
        
        // api request to save favorite location
        user?.favoriteLocations.append(newFavoriteLocation)
        
        return true
    }
    
    // get favorite locations
    func getFavoriteLocations () -> [Location]{
        guard let user = user else { return [] }
        
        return user.favoriteLocations
    }
    
    
}
