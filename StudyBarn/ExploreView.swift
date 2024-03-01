//
//  ExploreView.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/15/24.
//

import SwiftUI

struct ExploreView: View {
    
    @State private var showSearchView = false
    
    var body: some View {
        NavigationStack {
            if showSearchView {
                SearchView(show: $showSearchView)
            } else {
                ZStack {
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
                    .padding(.top, 70.0)
                    VStack {
                        SearchBar()
                            .onTapGesture {
                                withAnimation(.snappy) {
                                    showSearchView.toggle()
                                }
                            }
                        Spacer()
                    }

                }
            }
        }
        
        // for each renders the locations
        // create view for each box
    }
}

#Preview {
    ExploreView()
}
