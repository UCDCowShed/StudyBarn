//
//  SettingView.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/15/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("User Name")
                .font(Font.custom("RetroGaming", size: 15, relativeTo: .body))
            Text("Logout")
                .font(Font.custom("RetroGaming", size: 15, relativeTo: .body))
            Text("Reset")
                .font(Font.custom("RetroGaming", size: 15, relativeTo: .body))
            Text("Location services")
                .font(Font.custom("RetroGaming", size: 15, relativeTo: .body))
        }
    }
}

#Preview {
    SettingsView()
}
