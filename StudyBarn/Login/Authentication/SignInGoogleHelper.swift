//
//  SignInGoogleHelper.swift
//  StudyBarn
//
//  Created by JinLee on 2/22/24.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift

struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
}

final class SignInGoogleHelper {
    
    @MainActor // since accessing top view controller
    func signIn() async throws -> GoogleSignInResultModel {
        // get top most viewController
        // need to present the google signing sheet on the top most view Controller
        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        // sign in with google (from the modal)
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        // gidSignInResult.user.profile can contain names so we can extract them
        
        // extract idToken from the result
        guard let idToken: String = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        
        // extract token form the result
        let accessToken: String = gidSignInResult.user.accessToken.tokenString
        
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
        
        return tokens
    }
}
