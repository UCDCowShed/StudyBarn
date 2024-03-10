//
//  featureListingView.swift
//  StudyBarn
//
//  Created by JinLee on 3/9/24.
//

import SwiftUI

struct FeatureListingView: View {
    let area: AreaModel?
    let subArea: SubAreaModel?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 16) {
                // Outdoors
                if let area {
                    if area.outdoors ?? false {
                        VStack {
                            Image(systemName: "tree.fill")
                            Text("Outdoors")
                        }
                    }
                    if area.indoors ?? false {
                        VStack {
                            Image(systemName: "house.fill")
                            Text("Indoors")
                        }
                    }
                } else if let subArea {
                    VStack{
                        Image(systemName: subArea.outdoors ?? false ? "tree.fill" : "house.fill")
                        Text(subArea.outdoors ?? false ? "Outdoors" : "Indoors")
                    }
                }
                // Group Study
                if let area {
                    if area.groupStudy ?? false {
                        VStack {
                            Image(systemName: "speaker.wave.3.fill")
                            Text("GroupStudy")
                        }
                    }
                    if area.quietStudy ?? false {
                        VStack {
                            Image(systemName: "speaker.slash.fill")
                            Text("QuietStudy")
                        }
                    }
                } else if let subArea {
                    VStack{
                        Image(systemName: subArea.groupStudy ?? false ? "speaker.wave.3.fill" : "speaker.slash.fill")
                        Text(subArea.groupStudy ?? false ? "GroupStudy" : "QuietStudy")
                    }
                }
                // Printer
                if area?.printer ?? subArea?.printer ?? false {
                    VStack{
                        Image(systemName: "printer.fill")
                        Text("Printer")
                    }
                }
                // Dining
                if area?.dining ?? subArea?.dining ?? false {
                    VStack{
                        Image(systemName: "fork.knife")
                        Text("Dining")
                    }
                }
                // Outlets
                if area?.outlets ?? subArea?.outlets ?? false {
                    VStack{
                        Image(systemName: "poweroutlet.type.b.square.fill")
                        Text("Outlets")
                    }
                }
                // Microwave
                if area?.microwave ?? subArea?.microwave ?? false {
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
    }
}

#Preview {
    FeatureListingView(area: nil, subArea: nil)
}
