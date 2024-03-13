//
//  DetailsView.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/22/24.
//

import SwiftUI

struct DetailsView: View {
    @StateObject private var detailsViewModel: DetailsViewModel = DetailsViewModel()
    @EnvironmentObject private var viewModel: SelectViewModel
    @EnvironmentObject private var userViewModel: UserViewModel
    
    let area: AreaModel?
    let frequency: Int?
    let todayDate: String = Utilities.shared.getCurrentDate()
    
    @State private var loadingSubAreas = false
    @State private var allSubAreasFromArea: [SubAreaModel] = []
    
    var body: some View {
        ScrollView {
            // Area Images
            ListingCarouselView(area: area, subArea: nil, isArea: true)
                .frame(height: 320)
            
            // Details of Area
            HStack {
                // Area name and Time Range
                VStack (alignment: .leading, spacing: 4) {
                        Text("\(area?.name ?? "Test")")
                            .font(.title)
                            .fontWeight(.semibold)
                        // Default is "Closed"
                        Text(AreaManager.shared.formatHours(openHour: area?.openHour[todayDate] ?? HourMin(hour: 13, minute: 00), closeHour: area?.closeHour[todayDate] ?? HourMin(hour: 12, minute: 00)))
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    
                    
                }
                Spacer()
                VStack {
                    // Admin adding picture
                    if userViewModel.user?.admin ?? false {
                        // Images button
                        NavigationLink {
                            AddImageView(areaID: area?.areaId, isArea: true)
                        } label: {
                            Image(systemName: "photo")
                        }
                    }
                    // Showing Frequencies
                    VStack (spacing: 4){
                        Text("\(frequency ?? 0)")
                            .font(.title2)
                        Text("Visited")
                            .font(.footnote)
                    }

                }
                
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            if userViewModel.user?.admin ?? false {
                // Images button
                NavigationLink {
                    AddSubAreaView(areaId: area?.areaId)
                        .environmentObject(viewModel)
                } label: {
                    Text("Add subarea")
                }
            }
            
            // Display SubAreas
            VStack{
                if loadingSubAreas {
                    ProgressView()
                }
                else {
                    VStack(spacing: 50) {
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
                        allSubAreasFromArea = try await detailsViewModel.loadAllSubAreaFromArea(areaId: area.areaId) ?? []
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
    DetailsView(area: nil, frequency: nil)
        .environmentObject(SelectViewModel())
        .environmentObject(UserViewModel())
}
