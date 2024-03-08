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
    @Binding var allAreas: [AreaModel]
    @EnvironmentObject private var viewModel: SelectViewModel
    @State private var showSearchView = false
    
    var body: some View {
        NavigationStack{
            if showSearchView {
                SearchView(show: $showSearchView, areas: $allAreas)
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
    MapView(allAreas: .constant([AreaModel(areaId: "temp", name: "temp", rating: 0.0, images: ["temp/url"], openHour: HourMin(hour: 2, minute: 2), closeHour: HourMin(hour: 2, minute: 2), latitude: 100.0, longitude: -100.0)]))
        .environmentObject(SelectViewModel())
}
