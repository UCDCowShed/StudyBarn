//
//  LoginView.swift
//  StudyBarn
//
//  Created by JinLee on 2/22/24.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        GoogleLoginButton(showSignInView: $showSignInView)
    }
}

#Preview {
    LoginView(showSignInView: .constant(false))
}
