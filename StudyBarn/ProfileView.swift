//
//  SettingView.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/15/24.
//

import SwiftUI
import MapKit

struct ProfileView: View {
    
    @Binding var showSignInView: Bool
    @Binding var monitor: CLMonitor?
    @EnvironmentObject var viewModel: SelectViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var favoriteSubAreas: [SubAreaModel] = []
    
    var body: some View {
        NavigationView {
            // Entire View
            VStack {
                Spacer()
                // Profile Details / Logout
                VStack(alignment: .center, spacing: 10) {
                    HStack {
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
                                            .stroke(Color("TextColor"), lineWidth: 2)
                                    )
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        else {
                            Image("DefaultProfileImage")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color("TextColor"), lineWidth: 2)
                                )
                        }
                        // User Details
                        VStack (alignment: .leading){
                            // USER NAME
                            Text("\(userViewModel.user?.name ?? "User Name")")
                                .font(.headline)
                                .foregroundStyle(Color("TextColor"))
                            // USER EMAIL
                            Text("\(userViewModel.user?.email ?? "test@testtestestest.com")")
                                .foregroundStyle(Color("TextColor"))
                                .font(.subheadline)
                            Text("Logout")
                                .font(.caption)
                                .foregroundStyle(.red)
                                .onTapGesture {
                                    Task {
                                        do {
                                            try AuthenticationManager.shared.signOut()
                                            // Removes monitored areas
                                            await viewModel.removeMonitorAreas(monitor: monitor)
                                            showSignInView = true
                                        }
                                        catch {
                                            print("Failed Logout")
                                        }
                                    }
                                }
                                .frame(width: 60, height: 24)
                                .overlay( /// apply a rounded border
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(.red, lineWidth: 0.8)
                                )
                        }
                        .padding(.leading, 10)
                        Spacer()
                        
                    }
                }
                Spacer()
                
                Divider()
                    .padding(.vertical)
                
                // Favorites
                VStack(alignment: .leading, spacing: 7) {
                    VStack (alignment: .leading){
                        Text("Your Favorite Study Spots")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color("TextColor"))
                        Text("Add Your Favorite Study Spots!")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                        
                    }
                    .padding(.bottom, 6)
                    
                    ScrollView {
                        LazyVStack(spacing: 15) {
                            ForEach(favoriteSubAreas, id: \.self) { subArea in
                                SubAreaView(subArea: subArea)
                                    .padding(.top, 4)
                            }
                        }
                    }
                }
                .padding(.horizontal, 4)
                Spacer()
            }
            .padding()
            .onAppear() {
                Task {
                    do {
                        favoriteSubAreas = try await userViewModel.getAllFavoriteSubAreas()
                    }
                    catch {
                        print("Failed getting favorite subareas...")
                        print(error)
                    }
                }
            }
        }
    }
}


#Preview {
    ProfileView(showSignInView: .constant(false), monitor: .constant(nil))
        .environmentObject(UserViewModel())
        .environmentObject(SelectViewModel())
}
