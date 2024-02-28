//
//  SettingView.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/15/24.
//

import SwiftUI

struct ProfileView: View {
    
    @Binding var showSignInView: Bool
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .top) {
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 500, alignment: .center)
                VStack(alignment: .center, spacing: 10) {
                    // PROFILE IMAGE
                    if let userImage = userViewModel.user?.photoUrl {
                        AsyncImage(url: URL(string: userImage)) { image in
                            
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.black, lineWidth: 2)
                                )
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    else {
                        Image("profile")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.black, lineWidth: 2)
                            )
                    }
                    // USER NAME
                    Text("\(userViewModel.user?.name ?? "User Name")")
                    // USER EMAIL
                    Text("\(userViewModel.user?.email ?? "User Email")")
                    
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
                }
            }
        }
    }
}


#Preview {
    ProfileView(showSignInView: .constant(false))
        .environmentObject(UserViewModel())
}
