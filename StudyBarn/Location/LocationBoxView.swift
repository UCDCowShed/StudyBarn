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
                            .font(.custom("Futura", size: 24))
                        // Default is "Closed"
                        HStack {
                            Text(AreaManager.shared.formatHours(openHour: area?.openHour[todayDate] ?? HourMin(hour: 13, minute: 00), closeHour: area?.closeHour[todayDate] ?? HourMin(hour: 12, minute: 00)))
                                .font(.custom("Futura", size: 16))
                                .fontWeight(.light)
                                .foregroundStyle(.gray)
                            // Opened
                            if AreaManager.shared.determineOpenOrClose(openHour: area?.openHour[todayDate], closeHour: area?.closeHour[todayDate]) {
                                Text("Open")
                                    .font(.custom("Futura", size: 16))
                                    .foregroundStyle(.green)
                            }
                            // Closed
                            else {
                                Text("Closed")
                                    .font(.custom("Futura", size: 16))
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                    Spacer()
                    
                    // Visited times
                    VStack {
                        // Showing Frequencies
                        VStack (spacing: 2){
                            Text("\(area?.visited ?? 0)")
                                .font(.custom("Futura", size: 20))
                            Text("Visited")
                                .font(.custom("Futura", size: 14))
                        }
                    }
                    .font(.custom("Futura", size: 18))
                    .padding(.top, 3)
                }
            }
            
        }
    }
}

#Preview {
    LocationBoxView(area: nil)
}
