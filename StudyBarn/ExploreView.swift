//
//  ExploreView.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/15/24.
//

import SwiftUI

struct ExploreView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 50) {
                    ForEach(0...10, id: \.self) { location in
                        NavigationLink {
                            DetailsView()
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            LocationBoxView()
                                .frame(height:400)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
        }
        
        // for each renders the locations
            // create view for each box
    }
}

#Preview {
    ExploreView()
}
