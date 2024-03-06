//
//  ExploreView.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/15/24.
//

import SwiftUI

struct ExploreView: View {
    
    @StateObject private var viewModel: ExploreViewModel = ExploreViewModel()
    @EnvironmentObject private var userViewModel: UserViewModel
    
    @State private var showSearchView = false
    @State private var loadingAreas = true
    @State private var allAreas: [AreaModel] = []
    
    var body: some View {
        NavigationStack {
            // Display Search/Filter View
            if showSearchView {
                SearchView(show: $showSearchView, areas: $allAreas)
            }
            // Display Areas
            else {
                ZStack {
                    // Render areas
                    if !loadingAreas {
                        ScrollView {
                            LazyVStack(spacing: 50) {
                                ForEach(allAreas, id: \.self) { area in
                                    NavigationLink {
                                        DetailsView(area: area)
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
                    // Loading View when loading Areas
                    else {
                        ProgressView()
                    }
                    // Search Bar
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
                // Load Areas
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
            }
        }
    }
}

#Preview {
    ExploreView()
        .environmentObject(UserViewModel())
}
