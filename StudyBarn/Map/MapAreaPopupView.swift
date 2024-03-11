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
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text(area?.name ?? "Area")
                                .font(.title3)
                            // Default is "Closed"
                            Text(AreaManager.shared.formatHours(openHour: area?.openHour[todayDate] ?? HourMin(hour: 13, minute: 00), closeHour: area?.closeHour[todayDate] ?? HourMin(hour: 12, minute: 00)))
                                .font(.subheadline)
                        }
                        Spacer()
                        // Open/Close Indicator
                        VStack {
                            // Opened
                            if AreaManager.shared.determineOpenOrClose(openHour: area?.openHour[todayDate], closeHour: area?.closeHour[todayDate]) {
                                Text("Open")
                                    .font(.headline)
                                    .foregroundStyle(.green)
                            }
                            // Closed
                            else {
                                Text("Closed")
                                    .font(.headline)
                                    .foregroundStyle(.red)
                            }
                            
                        }
                        
                    }
                    FeatureListingView(area: area, subArea: nil)
                }
                .padding()
            }
        }
    }
}

#Preview {
    MapAreaPopupView(area: nil)
}
