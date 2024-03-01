//
//  DetailsView.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/22/24.
//

import SwiftUI

struct DetailsView: View {
    var body: some View {
        ScrollView {
            // Add Custom Back Button
            // Delete Graph
            // Make SubArea to have larger box
            ListingCarouselView()
                .frame(height: 320)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Peter S. Shields Library")
                    . font(.title)
                    .fontWeight(.semibold)
                
                VStack(alignment: .leading){
                    HStack(spacing: 5){
                        Image(systemName: "heart.fill")
                        Text("5.00")
                    }
                    .font(.subheadline)
                    Text("7:30am - 12:00am")
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
        }
        .ignoresSafeArea()
    }
}

#Preview {
    DetailsView()
}
