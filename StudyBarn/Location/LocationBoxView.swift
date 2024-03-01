//
//  LocationBoxView.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/16/24.
//

import SwiftUI

struct LocationBoxView: View {
    @State var heart = "heart"
    let area: AreaModel?
    
    public init(area: AreaModel?) {
            self.area = area
    }
    
    private var images = [
        "Shields-outside",
        "Shields-inside",
        "Shields-reading",
        "Shields-tutor"
    ]
    
    private func formatHours (hours: HourMin?) -> String {
        guard let hours = hours else { return "00:00"}
        
        // PM
        if hours.hour > 12 {
            let formatHour = hours.hour - 12
            return "\(formatHour):\(hours.minute) PM"
        }
        // 12 PM
        else if hours.hour == 12 {
            return "\(hours.hour):\(hours.minute) PM"
        }
        // AM
        else {
            return "\(hours.hour):\(hours.minute) AM"
        }
        
    }
    
    var body: some View {
        VStack(spacing: 8) {
            TabView {
                ForEach(images, id: \.self) { image in
                    Image(image)
                        .resizable()
                        .scaledToFill()
                }
            }
            .frame(height: 320)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .tabViewStyle(.page)
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(area?.name ?? "Area")
                        .font(.title)
                    Text("\(formatHours(hours: area?.openHour)) - \(formatHours(hours: area?.closeHour))")
                        .font(.subheadline)
                }
                Spacer()
                VStack {
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                        Text("\(area?.rating ?? 5, specifier: "%.1f")")
                    }
                    .font(.subheadline)
                    Button {
                        heart = "heart.fill"
                    } label : {
                        Image(systemName: heart)
                            .font(.title2)
                            .foregroundColor(Color.red.opacity(0.8))
                    }
                }
                
            }
            .padding()
        }
    }
}

#Preview {
    LocationBoxView(area: nil)
}
