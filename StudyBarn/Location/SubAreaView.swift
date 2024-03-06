//
//  SubAreaView.swift
//  StudyBarn
//
//  Created by JinLee on 3/4/24.
//

import SwiftUI

struct SubAreaView: View {
    
    let subArea: SubAreaModel?
    
    var body: some View {
        HStack (alignment: .top) {
            ListingCarouselView(area: nil, subArea: subArea, isArea: false)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .frame(width: 120, height: 140)
                .tabViewStyle(.page)
            
            // Details of SubArea
            VStack {
                // Name, Rating, Floor, and Favorite
                HStack(alignment: .center) {
                    // Area name and Time Range
                    VStack (alignment: .leading, spacing: 4) {
                        Text("\(subArea?.name ?? "Test Sub")")
                            .fontWeight(.semibold)
                        // Rating
                        HStack(spacing: 2) {
                            Image(systemName: "star.fill")
                            Text("\(subArea?.rating ?? 0.0, specifier: "%.1f")")
                        }
                        // Floor
                        Text("Floor - \(subArea?.floor ?? 1)")
                    }
                    .font(.footnote)
                    Spacer()
                    // Is My Favorite Button
                    VStack (spacing: 10) {
                        HeartButtonView()
                    }
                    .padding(.bottom, 20)
                }
                Spacer()
                
                // Detailed Features
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 16) {
                        // Outdoors
                        VStack{
                            Image(systemName: subArea?.outdoors ?? false ? "house.fill" : "tree.fill")
                            Text(subArea?.outdoors ?? false ? "Indoors" : "Outdoors")
                        }
                        // Group Study
                        VStack{
                            Image(systemName: subArea?.groupStudy ?? false ? "speaker.wave.3.fill" : "speaker.slash.fill")
                            Text(subArea?.groupStudy ?? false ? "GroupStudy" : "QuietStudy")
                        }
                        // Printer
                        if subArea?.printer ?? false {
                            VStack{
                                Image(systemName: "printer.fill")
                                Text("Printer")
                            }
                        }
                        // Dining
                        if subArea?.food ?? false {
                            VStack{
                                Image(systemName: "fork.knife")
                                Text("Dining")
                            }
                        }
                        // Outlets
                        if subArea?.outlets ?? false {
                            VStack{
                                Image(systemName: "poweroutlet.type.b.square.fill")
                                Text("Outlets")
                            }
                        }
                        // Microwave
                        if subArea?.microwave ?? false {
                            VStack{
                                Image(systemName: "microwave.fill")
                                Text("Microwave")
                            }
                        }
                    }
                    .font(.footnote)
                    .foregroundStyle(Color("TitleFont"))
                    .fontWeight(.semibold)
                }
                .padding(.leading)
                .padding(.top)
                .scrollTargetBehavior(.paging)
                Spacer()
            }
            .padding(.horizontal, 8)
            
        }
        .frame(height: 140)
        .font(.caption)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

#Preview {
    SubAreaView(subArea: nil)
}
