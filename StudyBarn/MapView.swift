//
//  MapView.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/15/24.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let shields = CLLocationCoordinate2D(latitude: 38.5397, longitude: -121.7495)
    static let tlc = CLLocationCoordinate2D(latitude: 38.5387, longitude: -121.7542)
}

struct MapView: View {
    @State private var position : MapCameraPosition = .automatic
    
    @State private var searchResults: [AreaModel] = []
    
    @State private var showSearchView = false
    
    var body: some View {
        NavigationStack{
            if showSearchView {
                SearchView(show: $showSearchView, areas: $searchResults)
            } else {
                Map(position: $position) {
                    Marker("Shields", coordinate: .shields)
                    Marker("TLC", coordinate: .tlc)
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
}
