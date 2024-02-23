//
//  LocationBoxView.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/16/24.
//

import SwiftUI

struct LocationBoxView: View {
    @State var heart = "heart"
    
    var images = [
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
                    Text("Peter S. Shields Library")
                        .font(.title)
                    Text("7:30am - 12:00am")
                        .font(.subheadline)
                }
                Spacer()
                VStack {
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                        Text("5.00")
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
    LocationBoxView()
}
