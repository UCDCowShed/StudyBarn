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
            VStack () {
                VStack(alignment: .center, spacing: 10) {
                    // PROFILE IMAGE
                    if let userImage = userViewModel.user?.photoUrl {
                        AsyncImage(url: URL(string: userImage)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
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
                        .foregroundStyle(Color("TextColor"))
                    // USER EMAIL
                    Text("\(userViewModel.user?.email ?? "User Email")")
                        .foregroundStyle(Color("TextColor"))
                        .font(.subheadline)
            
                    Text("Logout")
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
                        .frame(width: 100, height: 30)
                        .overlay( /// apply a rounded border
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.red, lineWidth: 1)
                        )
                        .padding()
                }
                
                Spacer()
                
                LazyVStack(spacing: 50) {
                    ForEach(favoriteSubAreas, id: \.self) { subArea in
                        SubAreaView(subArea: subArea)
                            .padding()
                    }
                }
            }
            .onAppear() {
                Task {
                    do {
                        favoriteSubAreas = try await userViewModel.getAllFavoriteSubAreas()
                        print(favoriteSubAreas)
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
