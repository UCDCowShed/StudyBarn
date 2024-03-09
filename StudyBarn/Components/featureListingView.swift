//
//  featureListingView.swift
//  StudyBarn
//
//  Created by JinLee on 3/9/24.
//

import SwiftUI

struct featureListingView: View {
    let subArea: SubAreaModel?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 16) {
                // Outdoors
                VStack{
                    Image(systemName: subArea?.outdoors ?? false ? "tree.fill" : "house.fill")
                    Text(subArea?.outdoors ?? false ? "Outdoors" : "Indoors")
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
                if subArea?.dining ?? false {
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
    }
}

#Preview {
    featureListingView(subArea: nil)
}
