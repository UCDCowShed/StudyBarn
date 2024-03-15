//
//  MapAreaPopupView.swift
//  StudyBarn
//
//  Created by Ann Yip on 3/9/24.
//

import SwiftUI

struct MapAreaPopupView: View {
    
    let area: AreaModel?
    @EnvironmentObject var viewModel: SelectViewModel
    @Binding var gotoDetailsView: Bool
    @Binding var refresh: Bool
    let todayDate: String = Utilities.shared.getCurrentDate()
    
    var body: some View {
        if let area {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(height: 170)
                    .foregroundStyle(Color("PlainBG"))
                HStack(spacing: 8) {
                    TabView {
                        ListingCarouselView(area: area, subArea: nil, isArea: true)
                    }
                    .frame(width: 140, height: 170)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .tabViewStyle(.page)
                    // Detailed Features
                    VStack {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                Text(area.name)
                                    .font(.custom("Futura", size: 18))
                                // Default is "Closed"
                                Text(AreaManager.shared.formatHours(openHour: area.openHour[todayDate] ?? HourMin(hour: 13, minute: 00), closeHour: area.closeHour[todayDate] ?? HourMin(hour: 12, minute: 00)))
                                    .font(.custom("Futura", size: 14))
                                    .opacity(0.7)
                            }
                            Spacer()
                            // Open/Close Indicator
                            VStack {
                                // Opened
                                if AreaManager.shared.determineOpenOrClose(openHour: area.openHour[todayDate], closeHour: area.closeHour[todayDate]) {
                                    Text("Open")
                                        .foregroundStyle(.green)
                                }
                                // Closed
                                else {
                                    Text("Closed")
                                        .foregroundStyle(.red)
                                }
                            }
                            .font(.custom("Futura", size: 18))
                            
                        }
                        FeatureListingView(area: area, subArea: nil)
                    }
                    .padding()
                }.onTapGesture() {
                    gotoDetailsView = true
                }
            }
        } else if viewModel.areaCoordinates.isEmpty {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(height: 170)
                    .foregroundStyle(Color("PlainBG"))
                HStack {
                    Text("Nothing found, please refresh the page.")
                        .font(.custom("Futura", size: 16))
                }
            }.onTapGesture() {
                refresh = true
            }
        }
    }
}

#Preview {
    MapAreaPopupView(area: nil, gotoDetailsView: .constant(false), refresh: .constant(false))
        .environmentObject(SelectViewModel())
}
