//
//  RootView.swift
//  StudyBarn
//
//  Created by JinLee on 2/22/24.
//

import SwiftUI
import MapKit

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    @State var appFirstLaunched: Bool = true
    @State var monitor: CLMonitor? = nil
    
    var body: some View {
        ZStack {
            // Logged In, Show SelectView
            if !showSignInView {
                NavigationStack {
                    SelectView(showSignInView: $showSignInView, appFirstLaunched: $appFirstLaunched, monitor: $monitor)
                }
                .background {
                    Color("Details")
                        .ignoresSafeArea()
                }
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        // Not Logged In, Google Auth Login
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
