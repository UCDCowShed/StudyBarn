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
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
    }
}
