//
//  SettingView.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/15/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            // to center at top 2/3 of screen
            ZStack (alignment: .top) {
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 500, alignment: .center)
                VStack(alignment: .center, spacing: 10) {
                    Image("profile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.black, lineWidth: 2)
                        )
                    
                    Text("User's name")
                    
                    Text("Logout")
                        .foregroundColor(.red)
                        .onTapGesture {
                            print("LOGGING OUT")
                        }
                    
                    Text("Reset")
                        .foregroundColor(.red)
                        .onTapGesture {
                            print("RESET")
                        }

                    NavigationLink(destination: MapView()){
                        Text("Location services")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
}
            

#Preview {
    SettingsView()
}
