//
//  GoogleLoginButton.swift
//  CowShed
//
//  Created by JinLee on 2/9/24.
//

import SwiftUI

struct GoogleLoginButton: View {
    
    @State private var accountId: String = ""
    
    var body: some View {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
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
    GoogleLoginButton()
}
