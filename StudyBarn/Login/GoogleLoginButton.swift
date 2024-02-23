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
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 4)
                Text("Continue with Google")
                    .foregroundStyle(.black.opacity(0.5))
            }
            .font(.subheadline)
            .fontWeight(.semibold)
            .frame(width: 360, height: 48)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadow(color: .black.opacity(0.4), radius: 2)
            
        })
    }
}

#Preview {
    GoogleLoginButton(showSignInView: .constant(false))
}
