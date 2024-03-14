//
//  SubAreaView.swift
//  StudyBarn
//
//  Created by JinLee on 3/4/24.
//

import SwiftUI

struct SubAreaView: View {
    
    @EnvironmentObject private var viewModel: SelectViewModel
    @EnvironmentObject private var userViewModel: UserViewModel
    let subArea: SubAreaModel?
    let profile: Bool?
    
    var body: some View {
        HStack (alignment: .top) {
            ListingCarouselView(area: nil, subArea: subArea, isArea: false)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .frame(width: 120, height: 120)
                .tabViewStyle(.page)
            
            // Details of SubArea
            VStack {
                // Name, Rating, Floor, and Favorite
                HStack(alignment: .center) {
                    // Area name and Time Range
                    VStack (alignment: .leading, spacing: 4) {
                        if let profile {
                            if profile {
                                Text(viewModel.areasHashmap[subArea?.areaId ?? ""]?.name ?? "Area name")
                                    .font(.custom("Futura", size: 10))
                            }
                        }
                        Text("\(subArea?.name ?? "Test Sub")")
                            .font(.custom("Futura", size: 16))
                        // Rating
//                        HStack(spacing: 2) {
//                            Image(systemName: "star.fill")
//                            Text("\(subArea?.rating ?? 0.0, specifier: "%.1f")")
//                        }
                        // Floor
                        Text("Floor - \(subArea?.floor ?? 1)")
                            .font(.custom("Futura", size: 12))
                    }
                    .font(.footnote)
                    Spacer()
                    if userViewModel.user?.admin ?? false {
                        // Images button
                        NavigationLink {
                            AddImageView(areaID: subArea?.subAreaId, isArea: false)
                        } label: {
                            Image(systemName: "photo")
                        }
                    }
                    // Is My Favorite Button
                    VStack (spacing: 10) {
                        HeartButtonView(subAreaId: subArea?.subAreaId)
                            .environmentObject(userViewModel)
                    }
                    .padding(.bottom, 20)
                }
                Spacer()
                
                // Detailed Features
                FeatureListingView(area: nil, subArea: subArea)
                Spacer()
            }
            .padding(.horizontal, 8)
            
        }
        .frame(height: 140)
        .font(.caption)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

#Preview {
    SubAreaView(subArea: nil, profile: nil)
        .environmentObject(SelectViewModel())
        .environmentObject(UserViewModel())
}
