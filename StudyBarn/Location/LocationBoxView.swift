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
                    Text("\(AreaManager.shared.formatHours(hours: area?.openHour)) - \(AreaManager.shared.formatHours(hours: area?.closeHour))")
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
