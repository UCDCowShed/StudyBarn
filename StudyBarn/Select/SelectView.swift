//
//  SelectView.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/15/24.
//

import SwiftUI

struct SelectView: View {
    
    @Binding var showSignInView: Bool
    @StateObject private var viewModel: SelectViewModel = SelectViewModel()
    @StateObject var userViewModel = UserViewModel()
    @State var startMonitoring: Bool = false
    
    var body: some View {
        TabView {
            ExploreView(startMonitoring: $startMonitoring)
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }
                .environmentObject(viewModel)
                .environmentObject(userViewModel)
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
                .environmentObject(viewModel)
                .environmentObject(userViewModel)
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
                    .environmentObject(viewModel)
            }
        }
        // Load user from the database once app starts
        .task {
            try? await userViewModel.loadUser()
            // set user to selectViewModel when user gets loaded
            viewModel.setUserId(userId: userViewModel.user?.userId)
        }
        // Start Monitoring when the monitor is setup
        .onChange(of: startMonitoring) {
            Task {
                do {
                    try await viewModel.startMonitorAreas()
                }
                catch {
                    print(error)
                }
            }
        }
    }
}

#Preview {
    SelectView(showSignInView: .constant(false))
}
