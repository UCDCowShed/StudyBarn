//
//  GoogleLoginButton.swift
//  CowShed
//
//  Created by JinLee on 2/9/24.
//

import SwiftUI

struct GoogleLoginButton: View {
    
    @State private var accountId: String = ""
    @Binding var showSignInView: Bool
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        Button(action: {
            Task {
                do {
                    try await viewModel.signInGoogle()
                    showSignInView = false
                }
                catch {
                    print(error)
                }
            }
        }, label: {
            HStack {
                Image("GoogleLogo")
                    .resizable()
                    .frame(width: 26, height: 26)
                    .padding(.trailing, 4)
                Text("Sign in with Google")
                    .font(.custom("Futura", size: 16))
                    .foregroundStyle(.black.opacity(0.5))
            }
            .font(.subheadline)
            .fontWeight(.semibold)
            .frame(width: 250, height: 48)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .black.opacity(0.4), radius: 2)
            
        })
    }
}

#Preview {
    GoogleLoginButton(showSignInView: .constant(false))
}
