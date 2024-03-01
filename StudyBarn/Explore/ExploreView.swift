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
    @State private var loadingAreas = true
    @State private var allAreas: [AreaModel] = []
    
    var body: some View {
        NavigationStack {
            if showSearchView {
                SearchView(show: $showSearchView)
            } else {
                ZStack {
                    if !loadingAreas {
                        ScrollView {
                            LazyVStack(spacing: 50) {
                                ForEach(allAreas, id: \.self) { area in
                                    NavigationLink {
                                        DetailsView()
                                            .navigationBarBackButtonHidden(false)
                                    } label: {
                                        LocationBoxView(area: area)
                                            .frame(height:400)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                
                            }
                            .padding()
                        }
                        .padding(.top, 70.0)
                    }
                    else {
                        ProgressView()
                    }
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
                    allAreas = try await viewModel.loadAllArea() ?? []
                    loadingAreas = false
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
