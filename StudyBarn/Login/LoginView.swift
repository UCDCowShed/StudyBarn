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
        Image("StudyBarn")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200)
            .padding()
        Text("Let's get started.")
            .font(.custom("Futura", size: 28))
            .foregroundStyle(Color("TitleFont"))
        Divider()
            .padding()
        GoogleLoginButton(showSignInView: $showSignInView)
    }
}

#Preview {
    LoginView(showSignInView: .constant(false))
}
