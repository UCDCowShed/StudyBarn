//
//  HeartButtonView.swift
//  StudyBarn
//
//  Created by JinLee on 3/4/24.
//

import SwiftUI


struct HeartButtonView: View {
    let subAreaId: String?
    
    @State private var heart = "heart"
    @EnvironmentObject var userViewModel: UserViewModel

    func toggleFavorite(heart: String) -> String {
        guard let subAreaId = subAreaId else {
            print("Error with toggle favorite..")
            return "heart"
        }
        // Remove Favorites from the user
        if userViewModel.checkFavorite(locationId: subAreaId) ?? false {
            userViewModel.removeUserFavorite(favorite: subAreaId)
            return "heart"
        }
        // Add Favorites to the user
        else {
            userViewModel.addUserFavorite(favorite: subAreaId)
            return "heart.fill"
        }
    }
    
    var body: some View {
        Button {
            heart = toggleFavorite(heart: heart)
        } label : {
            Image(systemName: heart)
                .font(.title2)
                .foregroundColor(Color.red.opacity(0.8))
        }
        .onAppear() {
            heart = userViewModel.checkFavorite(locationId: subAreaId ?? "") ?? false ? "heart.fill" : "heart"
        }
    }
}

#Preview {
    HeartButtonView(subAreaId: "test")
        .environmentObject(UserViewModel())
}
