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
            Spacer().frame(height: 150)
            Image("profile")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            Spacer().frame(height: 50)
            
            Text("User Name")
//                .font(Font.custom("RetroGaming", size: 15, relativeTo: .body))
            Spacer().frame(height: 20)
            Text("Logout")
                .foregroundColor(.red)
                
            Text("Reset")
                .foregroundColor(.red)
               
            Text("Location services")
                .foregroundColor(.red)
            
            Spacer()
                
        }
    }
}

#Preview {
    SettingsView()
}
