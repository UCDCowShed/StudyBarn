//
//  RootView.swift
//  StudyBarn
//
//  Created by JinLee on 2/22/24.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    
    var body: some View {
        ZStack {
            if !showSignInView {
                NavigationStack {
                    SelectView(showSignInView: $showSignInView)
                }
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView, content: {
            NavigationStack {
                LoginView(showSignInView: $showSignInView)
            }
        })
    }
}

#Preview {
    NavigationStack {
        RootView()
    }
}
