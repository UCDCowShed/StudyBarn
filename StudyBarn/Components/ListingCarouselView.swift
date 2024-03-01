//
//  ListingCarouselView.swift
//  StudyBarn
//
//  Created by Jinho Yon on 2/29/24.
//

import SwiftUI

struct ListingCarouselView: View {
    var images = [
        "Shields-outside",
        "Shields-inside",
        "Shields-reading",
        "Shields-tutor"
    ]
    
    var body: some View {
        TabView {
            ForEach(images, id: \.self) { image in
                Image(image)
                    .resizable()
                    .scaledToFill()
            }
        }
        .tabViewStyle(.page)
        
    }
}

#Preview {
    ListingCarouselView()
}
