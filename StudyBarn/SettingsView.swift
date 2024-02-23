//
//  SettingView.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/15/24.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var showSignInView: Bool
    
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
                            Task {
                                do {
                                    try AuthenticationManager.shared.signOut()
                                    showSignInView = true
                                }
                                catch {
                                    print("Failed Logout")
                                }
                                                            }
                        }
                    
                    Text("Reset")
                        .foregroundColor(.red)
                        .onTapGesture {
                            print("RESET")
                        }
                }
            }
        }
    }
}
            

#Preview {
    SettingsView(showSignInView: .constant(false))
}
