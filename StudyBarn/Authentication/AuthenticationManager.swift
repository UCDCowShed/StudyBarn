//
//  AuthenticationMananger.swift
//  StudyBarn
//
//  Created by JinLee on 2/22/24.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString // convert to string
    }
}

@MainActor
final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init() {}
    
    // Get Authenticate User
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    // Sign out user
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    // Sign in with Google
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        // sign in to firebase with this credentials (GoogleAuthProvider is from firebase)
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signIn(credential: credential)
    }
    
    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel {
        // this saves the user within the sdk locally, so no need to use UserDefaults
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }
    

}
