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
    
    @State private var showSearchView = false
    @State private var loadingAreas = true
    @State private var firstLoaded: Bool = true
    
    var body: some View {
        NavigationStack {
            // Display Search/Filter View
            if showSearchView {
                SearchView(show: $showSearchView)
                    .environmentObject(viewModel)
            }
            // Display Areas
            else {
                ZStack {
                    // Render areas
                    if !loadingAreas {
                        // Reload if nothing is displayed
                        if viewModel.areasIds.isEmpty {
                            // Refresh Button
                            VStack {
                                Button {
                                    Task {
                                        try await viewModel.loadAllArea()
                                    }
                                } label: {
                                    VStack {
                                        Image(systemName: "arrow.clockwise.circle.fill")
                                            .font(.system(size: 40))
                                            .foregroundStyle(.gray)
                                    }
                                }
                                Text("Nothing Found.")
                                    .font(.title)
                                Text("Please Refresh it.")
                                    .font(.footnote)
                                    .foregroundStyle(.gray)
                            }
                        }
                        ScrollView {
                            VStack(spacing: 20) {
                                ForEach(viewModel.areasIds, id: \.self) { areaId in
                                    let area = viewModel.areasHashmap[areaId]
                                    NavigationLink {
                                        DetailsView(area: area)
                                            .environmentObject(viewModel)
                                            .environmentObject(userViewModel)
                                            .navigationBarBackButtonHidden(false)
                                    } label: {
                                        LocationBoxView(area: area)
                                            .frame(height:320)
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
                                try await viewModel.loadAllArea()
                                firstLoaded = false
                            }
                            loadingAreas = false
                        }
                        catch {
                            print(error)
                        }
                    }
                }
                .refreshable {
                    do {
                        loadingAreas = true
                        // Reload by push down
                        try await viewModel.loadAllArea()
                        loadingAreas = false
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}

#Preview {
    ExploreView()
        .environmentObject(SelectViewModel())
        .environmentObject(UserViewModel())
}
