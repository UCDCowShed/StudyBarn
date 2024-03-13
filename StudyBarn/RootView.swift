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
            if !showSignInView {
                NavigationStack {
                    SelectView(showSignInView: $showSignInView, appFirstLaunched: $appFirstLaunched, monitor: $monitor)
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
