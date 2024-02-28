//
//  LoginViewModel.swift
//  StudyBarn
//
//  Created by JinLee on 2/22/24.
//

import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        
        // Get User after authentication from Google
        let authResult = try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        
        // Initialize a USER with auth from Google
        let user = UserModel(auth: authResult)
        
        // Check if user exists
        let userExists = try await UserManager.shared.getUser(userId: user.userId)
        
        // User Does not exist
        if userExists == nil {
            // Create User into the database
            try await UserManager.shared.createNewUser(user: user)
            print("User Created")
        }
    }
}
