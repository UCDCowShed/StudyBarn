//
//  LocationBoxView.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/16/24.
//

import SwiftUI

struct LocationBoxView: View {

    let area: AreaModel?

    var body: some View {
        VStack(spacing: 8) {
            TabView {
                ListingCarouselView(area: area, subArea: nil, isArea: true)
            }
            .frame(height: 320)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .tabViewStyle(.page)
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
                }
                
            }
            .padding()
        }
    }
}

#Preview {
    LocationBoxView(area: nil)
}
