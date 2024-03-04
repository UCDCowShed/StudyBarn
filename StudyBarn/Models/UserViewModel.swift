//
//  UserViewModel.swift
//  StudyBarn
//
//  Created by JinLee on 2/27/24.
//

import Foundation

@MainActor
final class UserViewModel: ObservableObject {
    @Published private(set) var user: UserModel? = nil

    // Load Authenticated User from the Database
    func loadUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    // Add favorite area/building to the database
    func addUserFavorite(favorite: String) {
        guard let user else { return }
        
        Task {
            try await UserManager.shared.addUserFavorite(userId:user.userId, favorite: favorite)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    // Remove favorite area/building from the database
    func removeUserFavorite(favorite: String) {
        guard let user else { return }
        
        Task {
            try await UserManager.shared.removeUserFavorite(userId:user.userId, favorite: favorite)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    // Check if area/subarea in user's favorites
    func checkFavorite(locationId: String) -> Bool? {
        if let user = user {
            return user.favorites.contains(locationId)
        }
        return nil
    }
}
