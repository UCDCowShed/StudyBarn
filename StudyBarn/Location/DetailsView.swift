//
//  DetailsView.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/22/24.
//

import SwiftUI

struct DetailsView: View {
    @Env
    @StateObject private var viewModel: DetailsViewModel = DetailsViewModel()
    
    let area: AreaModel?
    
    @State private var loadingSubAreas = false
    @State private var allSubAreasFromArea: [SubAreaModel] = []
    
    var body: some View {
        ScrollView {
            // Area Images
            ListingCarouselView()
                .frame(height: 320)
            
            // Details of Area
            HStack {
                // Area name and Time Range
                VStack (alignment: .leading, spacing: 4) {
                    Text("\(area?.name ?? "Test")")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    // Rating
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                        Text("\(area?.rating ?? 0.0, specifier: "%.1f")")
                    }
                    
                    Text("\(AreaManager.shared.formatHours(hours: area?.openHour)) - \(AreaManager.shared.formatHours(hours: area?.closeHour))")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    
                }
                Spacer()
                
                // Is My Favorite Button
                VStack (spacing: 10) {
                   HeartButtonView()
                }
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            // Display SubAreas
            VStack{
                if loadingSubAreas {
                    ProgressView()
                }
                else {
                    LazyVStack(spacing: 50) {
                        ForEach(allSubAreasFromArea, id: \.self) { subArea in
                            SubAreaView(subArea: subArea)
                                .padding()
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
        .onAppear() {
            // Get All the SubAreas Corresponds to the Area
            Task {
                do {
                    if let area = self.area {
                        allSubAreasFromArea = try await viewModel.loadAllSubAreaFromArea(areaId: area.areaId) ?? []
                        loadingSubAreas = false
                    }
                }
                catch {
                    print(error)
                }
            }
            
        }
    }
}

#Preview {
    DetailsView(area: nil)
}
