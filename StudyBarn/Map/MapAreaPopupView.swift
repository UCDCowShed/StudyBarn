//
//  MapAreaPopupView.swift
//  StudyBarn
//
//  Created by Ann Yip on 3/9/24.
//

import SwiftUI

struct MapAreaPopupView: View {
    
    let area: AreaModel?
    let todayDate: String = Utilities.shared.getCurrentDate()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(height: 170)
                .foregroundStyle(Color("PlainBG"))
            HStack(spacing: 8) {
                TabView {
                    ListingCarouselView(area: area, subArea: nil, isArea: true)
                }
                .frame(height: 170)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .tabViewStyle(.page)
                // Detailed Features
                VStack {
                    FeatureListingView(area: area, subArea: nil)
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text(area?.name ?? "Area")
                                .font(.title3)
                            // Default is "Closed"
                            Text(AreaManager.shared.formatHours(openHour: area?.openHour[todayDate] ?? HourMin(hour: 13, minute: 00), closeHour: area?.closeHour[todayDate] ?? HourMin(hour: 12, minute: 00)))
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
                }
                .padding()
            }
        }
    }
}

#Preview {
    MapAreaPopupView(area: nil)
}
