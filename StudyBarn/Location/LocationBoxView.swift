//
//  LocationBoxView.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/16/24.
//

import SwiftUI

struct LocationBoxView: View {

    let area: AreaModel?
    let todayDate: String = Utilities.shared.getCurrentDate()

    var body: some View {
        VStack(spacing: 8) {
            TabView {
                ListingCarouselView(area: area, subArea: nil, isArea: true)
            }
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .tabViewStyle(.page)
            
            VStack{
                // Detailed Features
                FeatureListingView(area: area, subArea: nil)
                
                // Descriptions
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text(area?.name ?? "Area")
                            .font(.title)
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
                    .padding(.vertical)
                }
            }
            
        }
    }
}

#Preview {
    LocationBoxView(area: nil)
}
