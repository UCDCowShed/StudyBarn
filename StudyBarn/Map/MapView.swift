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
    @State private var showPopUp: (Bool, String) = (false, "")
    
    
    var body: some View {
        NavigationStack{
            if showSearchView {
                SearchView(show: $showSearchView)
                    .environmentObject(viewModel)
            } else {
                ZStack {
                    Map(position: $position) {
                        ForEach(Array(viewModel.areaCoordinates.keys), id: \.self) { areaId in
                            // Get area name and coordinates
                            let name = viewModel.areasHashmap[areaId]?.name
                            let coor = viewModel.areaCoordinates[areaId]
                            if let name = name, let coor = coor {
                                Annotation(name, coordinate: coor) {
                                        ZStack {
                                            Image(systemName: "circle.fill")
                                                .resizable()
                                                .frame(maxWidth: 45, maxHeight: 50)
                                                .padding(.bottom, 18)
                                                .foregroundStyle(Color("Pincolor"))
                                            Image(systemName: "triangle.fill")
                                                .frame(maxWidth: 40, maxHeight: 45)
                                                .rotationEffect(Angle(degrees: 180))
                                                .foregroundStyle(Color("Pincolor"))
                                            Image(systemName: "book")
                                                .resizable()
                                                .frame(maxWidth: 16, maxHeight: 13)
                                                .padding(.bottom, 15)
                                                .foregroundStyle(.white)
                                        }
                                        .padding(30)
                                        .onTapGesture() {
                                            showPopUp = (true, areaId)
                                        }
                                        .padding(-30)
                                }
                                // show area pop up when clicked on, pass in area here
                            }
                        }
                    }
                    .onTapGesture {
                        showPopUp = (false, "")
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
                    if showPopUp.0 {
                        VStack {
                            Spacer()
                            MapAreaPopupView(area: viewModel.areasHashmap[showPopUp.1])
                        }
                        .padding()

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
