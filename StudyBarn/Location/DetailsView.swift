//
//  DetailsView.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/22/24.
//

import SwiftUI

struct DetailsView: View {
    @StateObject private var viewModel: DetailsViewModel = DetailsViewModel()
    
    let area: AreaModel?
    
    @State private var loadingSubAreas = true
    @State private var allSubAreasFromArea: [SubAreaModel] = []
    
    public init(area: AreaModel?) {
            self.area = area
    }
    
    var body: some View {
        ScrollView {
            // Add Custom Back Button
            // Delete Graph
            // Make SubArea to have larger box
            ListingCarouselView()
                .frame(height: 320)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("\(area?.name ?? "Test")")
                    . font(.title)
                    .fontWeight(.semibold)
                
                VStack(alignment: .leading){
                    HStack(spacing: 5){
                        Image(systemName: "heart.fill")
                        Text("\(area?.rating ?? 5, specifier: "%.1f")")
                    }
                    .font(.subheadline)
                    Text("\(AreaManager.shared.formatHours(hours: area?.openHour)) - \(AreaManager.shared.formatHours(hours: area?.closeHour))")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
            }
            .padding(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            VStack{
                HStack(spacing: 3){
                    HStack{
                        Image(systemName: "wifi")
                        VStack(alignment: .leading) {
                            Text("Wifi")
                                .font(.footnote)
                                .fontWeight(.semibold)
                            Text("Available")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundStyle(.green)
                        }
                        HStack{
                            Image(systemName: "dog")
                            VStack(alignment: .leading) {
                                Text("Pet")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                Text("Not Allowed")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.red)
                            }
                        }
                        
                        HStack{
                            Image(systemName: "fork.knife")
                            VStack(alignment: .leading) {
                                Text("Food")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                Text("Available")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.green)
                            }
                        }
                        
                        HStack{
                            Image(systemName: "person.2.fill")
                            VStack(alignment: .leading) {
                                Text("Group Study")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                Text("Available")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.green)
                            }
                        }
                        
                    }
                }.padding()
                
                Divider()
                
                VStack {
                    Text("Busy Hours")
                        .font(.headline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Image("busy-hours")
                        .resizable()
                        .scaledToFit()
                }
                
                Divider()
                
                VStack(spacing: 13){
                    Text("Study Spots")
                        .font(.headline)
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 16) {
                            ForEach(1 ..< 5) { studyrooms in
                                VStack{
                                    Image(systemName: "house")
                                    Text("Main Reading Room")
                                }
                                .frame(width: 132, height: 100)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(lineWidth: 1)
                                        .foregroundStyle(.gray)
                                }
                            }
                        }
                    }
                    .scrollTargetBehavior(.paging)
                }
            }
            
            // Display SubAreas
            VStack{
                if loadingSubAreas {
                    ProgressView()
                }
                else {
                    LazyVStack(spacing: 50) {
                        ForEach(allSubAreasFromArea, id: \.self) { subArea in
                            Text("\(subArea.name)")
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
