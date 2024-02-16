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
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.black, lineWidth: 2)
                )
            
            Spacer().frame(height: 15)
            
            Text("User's name")
//                .font(Font.custom("RetroGaming", size: 15, relativeTo: .body))
            Spacer().frame(height: 30)
            
            Text("Logout")
                .foregroundColor(.red)
                .onTapGesture {
                    print("Logging out...")
                }
            Spacer().frame(height: 15)
            
            Text("Reset")
                .foregroundColor(.red)
                .onTapGesture {
                    print("RESET")
                }
            Spacer().frame(height: 15)
            
            Text("Location services")
                .foregroundColor(.red)
                .onTapGesture {
                    print("Location Services")
                }
            
            Spacer()
                
        }
    }
}

#Preview {
    SettingsView()
}
