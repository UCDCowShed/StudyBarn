//
//  HeartButtonView.swift
//  StudyBarn
//
//  Created by JinLee on 3/4/24.
//

import SwiftUI

@MainActor
final class HeartButtonViewModel: ObservableObject {
    func toggleFavorite(heart: String, userId: String, favorite: String) -> String {
        if heart == "heart" {
                    // add functionality for adding and removing the favorite from the user
                    do {
                        try await addUserFavorite(userId: userId, favorite: favorite)
                    } catch {
                        // error
                        print("Error adding favorite: \(error)")
                    }
                } else {
                    removeUserFavorite(userId: userId, favorite: favorite)
                }
        
        return heart == "heart" ? "heart.fill" : "heart"
    }
}

struct HeartButtonView: View {
    
    @State private var heart = "heart"
    @StateObject private var viewModel: HeartButtonViewModel = HeartButtonViewModel()

    
    var body: some View {
        Button {
            heart = viewModel.toggleFavorite(heart: heart)
        } label : {
            Image(systemName: heart)
                .font(.title2)
                .foregroundColor(Color.red.opacity(0.8))
        }
        .onAppear{
            // Initialize the Heart Type ("Heart Fill" if my favorite)
//            if let isMyFavorite = isMyFavorite {
//                heart = isMyFavorite ? "heart.fill" : "heart"
//            }
        }
            
    }
}

#Preview {
    HeartButtonView()
}
