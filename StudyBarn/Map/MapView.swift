//
//  MapView.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/15/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var mapViewModel: MapViewModel = MapViewModel()
    @State private var position : MapCameraPosition = .userLocation(fallback: .automatic)
    @EnvironmentObject private var viewModel: SelectViewModel
    @EnvironmentObject private var userViewModel: UserViewModel
    @State private var showSearchView = false
    @State private var showPopUp: (Bool, String) = (false, "")
    @State var gotoDetailsView: Bool = false
    @State var refresh: Bool = false
    
    
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
                                    Button {
                                        showPopUp = (true, areaId)
                                        print("clicked, showPopUp = \(showPopUp.0) areaId = \(showPopUp.1)")
                                    } label: {
                                        ZStack {
                                            Image(systemName: "circle.fill")
                                                .font(.system(size: 25))
                                                .padding(.bottom, 18)
                                                .foregroundStyle(Color("Pincolor"))
                                            Image(systemName: "triangle.fill")
                                                .font(.system(size: 25))
                                                .rotationEffect(Angle(degrees: 180))
                                                .foregroundStyle(Color("Pincolor"))
                                            Image(systemName: "book")
                                                .resizable()
                                                .frame(maxWidth: 15, maxHeight: 12)
                                                .padding(.bottom, 15)
                                                .foregroundStyle(.white)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .mapControls {
                        MapUserLocationButton()
                        MapPitchToggle()
                    }
                    .onAppear() {
                        mapViewModel.checkIfLocationServiceIsEnabled()
                    }
                    .onChange(of: refresh) {
                        if refresh {
                            Task {
                                try await viewModel.loadAllArea()
                            }
                            position = .automatic
                            refresh = false
                        }
                    }
                    .safeAreaInset(edge: .top) {
                        HStack {
                            SearchBar()
                                .onTapGesture {
                                    withAnimation(.snappy) {
                                        showSearchView.toggle()
                                    }
                                    position = .userLocation(fallback: .automatic)
                                }
                        }
                    }
                    VStack {
                        Spacer()
                        if showPopUp.0 {
                            MapAreaPopupView(area: viewModel.areasHashmap[showPopUp.1], gotoDetailsView: $gotoDetailsView, refresh: $refresh)
                                .environmentObject(viewModel)
                                .padding()
                        }
                    }
                    .onTapGesture {
                        showPopUp = (false, "")
                    }
                }
                .onChange(of: showSearchView) {
                    position = .automatic
                    if Array(viewModel.areaCoordinates.keys).isEmpty {
                        showPopUp = (false, "")
                    }
                    position = .userLocation(fallback: .automatic)
                }
                .navigationDestination(isPresented: $gotoDetailsView) {
                    DetailsView(area: viewModel.areasHashmap[showPopUp.1])
                        .environmentObject(viewModel)
                        .environmentObject(userViewModel)
                }
            }
        }
    }
}

#Preview {
    MapView()
        .environmentObject(SelectViewModel())
        .environmentObject(UserViewModel())
}
