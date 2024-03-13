//
//  ListingCarouselView.swift
//  StudyBarn
//
//  Created by Jinho Yon on 2/29/24.
//

import SwiftUI

struct ListingCarouselView: View {
    let area: AreaModel?
    let subArea: SubAreaModel?
    let isArea: Bool?
    
    @State private var urls: [URL]? = nil
    
    var body: some View {
        TabView {
            if let urls {
                ForEach(urls, id: \.self) { url in
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                }
            } else {
                Image("Shields-outside")
            }
        }
        .tabViewStyle(.page)
        .task {
            if let area = area, let isArea = isArea {
                if let images = area.images {
                    if !images.isEmpty {
                        let urls = try? await ImageManager.shared.getAllImages(areaID: area.areaId, images: images, isArea: isArea)
                        self.urls = urls
                    }
                }
            }
            if let subArea = subArea, let isArea = isArea {
                if let images = subArea.images {
                    if !images.isEmpty {
                        print("subarea view images loading")
                        let urls = try? await ImageManager.shared.getAllImages(areaID: subArea.subAreaId, images: images, isArea: isArea)
                        print("got images for subarea")
                        self.urls = urls
                    }
                }
            }
        }
    }
}

#Preview {
    ListingCarouselView(area: nil, subArea: nil, isArea: nil)
}
