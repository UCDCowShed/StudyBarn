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
    @StateObject var profileViewModel = ProfileViewModel()
    @EnvironmentObject var viewModel: SelectViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var favoriteSubAreas: [SubAreaModel] = []
    @State private var recommendedSubAreas: [SubAreaModel] = []
    @State private var recCollapsed: Bool = true
    @State private var favCollapsed: Bool = true
    @State private var loadedRecommendedArea: Bool = false
    
    var body: some View {
        NavigationView {
            // Entire View
            VStack {
                // Profile Details / Logout
                VStack(alignment: .center, spacing: 7) {
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
                                .font(.custom("Futura", size: 18))
                                .fontWeight(.semibold)
                                .foregroundStyle(Color("TextColor"))
                            // USER EMAIL
                            Text("\(userViewModel.user?.email ?? "test@testtestestest.com")")
                                .foregroundStyle(Color("TextColor"))
                                .font(.custom("Futura", size: 16))
                            Text("Logout")
                                .font(.custom("Futura", size: 12))
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
                        .padding(.leading, 16)
                        Spacer()
                    }
                }
                .padding()
                
                Divider()
                    .padding(.top)
                
                // Recommendation
                VStack(alignment: !recommendedSubAreas.isEmpty ? .leading : .center, spacing: 7) {
                    VStack (alignment: !recommendedSubAreas.isEmpty ? .leading : .center){
                        HStack {
                            Text("Your Recommended Study Spots")
                                .font(.custom("Futura", size: 18))
                                .fontWeight(.semibold)
                                .foregroundStyle(Color("TextColor"))
                            Spacer()
                            Button {
                                recCollapsed.toggle()
                            } label: {
                                Image(systemName: recCollapsed ? "chevron.down" : "chevron.up")
                                    .foregroundStyle(.gray)
                                    .padding()
                            }
                        }
                        if !recCollapsed {
                            if loadedRecommendedArea {
                                // No Recommended Areas
                                if recommendedSubAreas.isEmpty {
                                    // Refresh Button
                                    VStack {
                                        Button {
                                            Task {
                                                loadedRecommendedArea = false
                                                recommendedSubAreas = try await profileViewModel.loadRecommendedAreas(userId: userViewModel.user?.userId)
                                                loadedRecommendedArea = true
                                            }
                                        } label: {
                                            VStack {
                                                Image(systemName: "arrow.clockwise.circle.fill")
                                                    .font(.system(size: 40))
                                                    .foregroundStyle(.gray)
                                            }
                                        }
                                        Text("Nothing Found.")
                                            .font(.custom("Futura", size: 20))
                                        Text("Please Refresh it.")
                                            .font(.custom("Futura", size: 14))
                                            .foregroundStyle(.gray)
                                    }
                                    .padding(.vertical, 40)
                                }
                                // show list of recommendation here
                                else {
                                    ScrollView {
                                        LazyVStack(spacing: 15) {
                                            ForEach(recommendedSubAreas, id: \.self) { subArea in
                                                SubAreaView(subArea: subArea, profile: true)
                                                    .padding(.top, 4)
                                            }
                                        }
                                    }
                                }
                            }
                            else {
                                ProgressView()
                            }
                        }
                    }
                    .padding(.bottom, 6)
                }
                .padding(.horizontal, 4)
                
                Divider()
                
                // Favorites
                VStack(alignment: .leading, spacing: 7) {
                    HStack {
                        
                        VStack (alignment: .leading){
                            Text("Your Favorite Study Spots")
                                .font(.custom("Futura", size: 18))
                                .fontWeight(.semibold)
                                .foregroundStyle(Color("TextColor"))
                            if favoriteSubAreas.isEmpty {
                                Text("Add Your Favorite Study Spots!")
                                    .font(.custom("Futura", size: 16))
                                    .foregroundStyle(.gray)
                            }
                        }
                        Spacer()
                        Button {
                            favCollapsed.toggle()
                        } label: {
                            Image(systemName: favCollapsed ? "chevron.down" : "chevron.up")
                                .foregroundStyle(.gray)
                                .padding()
                        }
                    }
                    .padding(.bottom, 6)
                    
                    if !favCollapsed {
                        ScrollView {
                            LazyVStack(spacing: 15) {
                                ForEach(favoriteSubAreas, id: \.self) { subArea in
                                    SubAreaView(subArea: subArea, profile: true)
                                        .padding(.top, 4)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 4)
                Spacer()
            }
            .padding()
            .background {
                Color("Details")
                    .ignoresSafeArea()
            }
            .onAppear() {
                Task {
                    do {
                        favoriteSubAreas = try await userViewModel.getAllFavoriteSubAreas()
                        recommendedSubAreas = try await profileViewModel.loadRecommendedAreas(userId: userViewModel.user?.userId)
                        loadedRecommendedArea = true
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
