//
//  MapAreaPopupView.swift
//  StudyBarn
//
//  Created by Ann Yip on 3/9/24.
//

import SwiftUI

struct MapAreaPopupView: View {
    
    let area: AreaModel?
    
    var body: some View {
        VStack(spacing: 8) {
            TabView {
                ListingCarouselView(area: area, subArea: nil, isArea: true)
            }
            .frame(height: 170)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .tabViewStyle(.page)
            // Scroll view of features
            ScrollView(.horizontal, showsIndicators: false){
                HStack (spacing: 18) {
                    Image(systemName: "tree.fill")
                    Image(systemName: "house.fill")
                    Image(systemName: "printer.fill")
                    Image(systemName: "desktopcomputer")
                }.padding(.horizontal)
            }
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(area?.name ?? "Area")
                        .font(.title)
                    Text("\(AreaManager.shared.formatHours(hours: area?.openHour)) - \(AreaManager.shared.formatHours(hours: area?.closeHour))")
                        .font(.subheadline)
                }
                Spacer()
                VStack {
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                        Text("\(area?.rating ?? 0.0, specifier: "%.1f")")
                    }
                    .font(.subheadline)
                    HeartButtonView()
                        .padding(.top, 8.0)
                }
                
            }
            .padding()
        }
    }
}

#Preview {
    MapAreaPopupView(area: nil)
}
