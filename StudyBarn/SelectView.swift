//
//  SelectView.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/15/24.
//

import SwiftUI

struct SelectView: View {
    
    @Binding var showSignInView: Bool
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View {
        TabView {
            ExploreView()
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }
                .environmentObject(userViewModel)
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
            ProfileView(showSignInView: $showSignInView)
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .environmentObject(userViewModel)
            if userViewModel.user?.admin ?? false {
                AdminView()
                    .tabItem {
                        Label("Admin", systemImage: "folder")
                    }
            }
        }
        // Load user from the database once app starts
        .task {
            try? await userViewModel.loadUser()
        }
    }
}

#Preview {
    SelectView(showSignInView: .constant(false))
}
