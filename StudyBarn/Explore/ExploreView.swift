//
//  ExploreView.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/15/24.
//

import SwiftUI

struct ExploreView: View {
    
    @EnvironmentObject private var viewModel: SelectViewModel
    @EnvironmentObject private var userViewModel: UserViewModel
    @Binding var allAreas: [AreaModel]
    
    @State private var showSearchView = false
    @State private var loadingAreas = true
    @State private var firstLoaded: Bool = true
    
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
                                            .environmentObject(userViewModel)
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
                            // Load only when no areas to display
                            if firstLoaded {
                                allAreas = try await viewModel.loadAllArea() ?? []
                                firstLoaded = false
                            }
                            loadingAreas = false
                        }
                        catch {
                            print(error)
                            allAreas = []
                        }
                    }
                }
                .refreshable {
                    do {
                        loadingAreas = true
                        // Reload by push down
                        allAreas = try await viewModel.loadAllArea() ?? []
                        loadingAreas = false
                    } catch {
                        print(error)
                        allAreas = []
                    }
                }
            }
        }
    }
}

#Preview {
    ExploreView(allAreas: .constant([AreaModel(areaId: "temp", name: "temp", rating: 0.0, images: ["temp/url"], openHour: HourMin(hour: 2, minute: 2), closeHour: HourMin(hour: 2, minute: 2), latitude: 100.0, longitude: -100.0)]))
        .environmentObject(SelectViewModel())
        .environmentObject(UserViewModel())
}
