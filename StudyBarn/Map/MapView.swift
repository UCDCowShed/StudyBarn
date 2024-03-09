//
//  MapView.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/15/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var position : MapCameraPosition = .automatic
    @EnvironmentObject private var viewModel: SelectViewModel
    @State private var showSearchView = false
    
    var body: some View {
        NavigationStack{
            if showSearchView {
                SearchView(show: $showSearchView)
                    .environmentObject(viewModel)
            } else {
                Map(position: $position) {
                    ForEach(Array(viewModel.areaCoordinates.keys), id: \.self) { name in
                        if let coor = viewModel.areaCoordinates[name] {
                            Marker(name, coordinate: coor)
                            // show area pop up when clicked on, pass in area here
                                //.onTapGesture(count: Int, perform: <#T##() -> Void#>)
                        }
                    }
                }
                .safeAreaInset(edge: .top) {
                    HStack {
                        SearchBar()
                            .onTapGesture {
                                withAnimation(.snappy) {
                                    showSearchView.toggle()
                                }
                                position = .automatic
                            }
                    }
                }
                .onChange(of: showSearchView) {
                    position = .automatic
                }
            }
        }
    }
}

#Preview {
    MapView()
        .environmentObject(SelectViewModel())
}
