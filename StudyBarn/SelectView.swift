//
//  SelectView.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/15/24.
//

import SwiftUI

struct SelectView: View {
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        TabView {
            ExploreView()
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
            FavoriteView()
                .tabItem {
                    Label("Saved", systemImage: "heart")
                }
            SettingsView(showSignInView: $showSignInView)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

#Preview {
    SelectView(showSignInView: .constant(false))
}
