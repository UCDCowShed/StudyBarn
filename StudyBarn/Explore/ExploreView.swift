//
//  ExploreView.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/15/24.
//

import SwiftUI

struct ExploreView: View {
    
    @StateObject private var viewModel: ExploreViewModel = ExploreViewModel()
    
    @State private var showSearchView = false
    @State private var allAreas: [AreaModel]? = []
    
    var body: some View {
        NavigationStack {
            if showSearchView {
                SearchView(show: $showSearchView)
            } else {
                ZStack {
                    ScrollView {
                        LazyVStack(spacing: 50) {
                            if let allAreas = allAreas {
                                ForEach(allAreas, id: \.self) { area in
                                    NavigationLink {
                                        DetailsView()
                                            .navigationBarBackButtonHidden(true)
                                    } label: {
                                        LocationBoxView(area: area)
                                            .frame(height:400)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
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
        .onAppear() {
            Task {
                do {
                    allAreas = try await viewModel.loadAllArea()
                }
                catch {
                    print(error)
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
