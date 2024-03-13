//
//  SelectView.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/15/24.
//

import SwiftUI
import MapKit

struct SelectView: View {
    
    @Binding var showSignInView: Bool
    @Binding var appFirstLaunched: Bool
    @Binding var monitor: CLMonitor?
    @StateObject private var viewModel: SelectViewModel = SelectViewModel()
    @StateObject var userViewModel = UserViewModel()
    @State var startMonitoring: Bool = false
    
    var body: some View {
        TabView {
            ExploreView(startMonitoring: $startMonitoring, monitor: $monitor)
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
            ProfileView(showSignInView: $showSignInView, monitor: $monitor)
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .environmentObject(viewModel)
                .environmentObject(userViewModel)
            if userViewModel.user?.admin ?? false {
                AdminView()
                    .tabItem {
                        Label("Admin", systemImage: "folder")
                    }
                    .environmentObject(viewModel)
            }
        }
        .font(.custom("Futura", size: 18))
        // Load user from the database once app starts
        .task {
            try? await userViewModel.loadUser()
            // set user to selectViewModel when user gets loaded
            viewModel.setUserId(userId: userViewModel.user?.userId)
        }
        // Start Monitoring when the monitor is setup
        .onChange(of: startMonitoring) {
            Task {
                // Initialize and start monitoring user movements
                if appFirstLaunched {
                    print("here")
                    monitor = await viewModel.initializeMonitor()
                    appFirstLaunched = false
                }
                await viewModel.startMonitorAreas(monitor: monitor)
            }
        }
    }
}

#Preview {
    SelectView(showSignInView: .constant(false), appFirstLaunched: .constant(false), monitor: .constant(nil))
}
