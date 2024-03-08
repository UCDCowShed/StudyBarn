//
//  SearchButton.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/25/24.
//

import SwiftUI

enum SearchOptions {
    case location
    case building
}

struct SearchView: View {
    @Binding var show : Bool
    @StateObject var filterViewModel = FilterViewModel()
    @EnvironmentObject private var viewModel: SelectViewModel
    
    @State var multiSelection = Set<UUID>()
    @State var extend_filter : Bool = false
    @State var search: String = ""
    
    var body: some View {
        VStack {
            // Search Bar
//            VStack(alignment: .leading){
//                Text("")
//                    .font(.title2)
//                    .fontWeight(.semibold)
//                HStack {
//                    Image(systemName: "magnifyingglass")
//                        .imageScale(.small)
//                    TextField("Search", text: $search)
//                        .font(.subheadline)
//                }
//                .frame(height: 45)
//                .padding(.horizontal)
//                .overlay {
//                    RoundedRectangle(cornerRadius: 5)
//                        .stroke(lineWidth: 0.5)
//                        .foregroundStyle(Color(.systemGray4))
//                        .shadow(color: .black.opacity(0.4), radius:2)
//                }
//            }
//            .padding()
//            .clipShape(RoundedRectangle(cornerRadius: 5))
//            .shadow(radius: 10)
            
            // Determine Collapsing Filter View
            if extend_filter {
                ExtendedFilterView()
                    .padding(.top, 20)
                    .environmentObject(filterViewModel)
                    .onTapGesture {
                        extend_filter.toggle()
                    }
            } else {
                CollapsedFilterView()
                    .padding(.top, 20)
                    .onTapGesture {
                        extend_filter.toggle()
                    }
            }
            
            Spacer()
            
            // Buttons
            HStack {
                // Back button
                Button {
                    withAnimation(.snappy) {
                        show.toggle()
                    }
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundStyle(Color("TextColor").opacity(0.8))
                }
                Spacer()
                
                // Search button
                Button {
                    Task {
                        // Get Filtered results
                        do {
                            let filteredAreas = try await filterViewModel.getFilteredAreas(atmosphereFilter: filterViewModel.atmosphereFilter, volumeFilter:filterViewModel.volumeFilter, featureFilter: filterViewModel.featureFilter)
                            // Update Areas when there are filters applied
                            if let filteredAreas = filteredAreas {
                                viewModel.areas = filteredAreas
                                viewModel.getCoordinates(areas: viewModel.areas ?? [])
                            }
                        }
                        catch {
                            print(error)
                        }
                    }
                    withAnimation(.snappy) {
                        show.toggle()
                    }
                } label: {
                    HStack {
                        Text("Search")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundStyle(Color("TextColor").opacity(0.8))
                }
            }
            .padding()
        }   
    }
}

struct ExtendedFilterView: View {
    @EnvironmentObject var filterViewModel: FilterViewModel
    
    var body: some View {
        VStack{
            HStack {
                Text("Choose filters")
                    .padding()
                    .font(.subheadline)
                    .foregroundStyle(Color("TextColor").opacity(0.7))
                Spacer()
                Image(systemName: "chevron.up")
                    .padding()
                    .foregroundStyle(Color("TextColor"))
            }
            VStack {
                HStack {
                    Text("Atmosphere")
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(Color("TitleFont"))
                    Spacer()
                }
                .padding([.top, .trailing])
                ForEach(filterViewModel.atmosphereFilter) { filter in
                    HStack {
                        Image(systemName: filter.selected ? "checkmark.square.fill" : "square")
                            .font(.footnote)
                        Text(filter.name.capitalizedWord)
                        Spacer()
                    }
                    .font(.subheadline)
                    .padding([.top, .leading, .trailing])
                    .foregroundStyle(Color("FilterList"))
                    .contentShape(Rectangle())
                    .onTapGesture {
                        filterViewModel.atmoFilterRowTapped(filterRow: filter)
                    }
                }
                .padding([.top, .trailing])
                
                HStack {
                    Text("Volume Levels")
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(Color("TitleFont"))
                    Spacer()
                }
                .padding([.top, .trailing])
                ForEach(filterViewModel.volumeFilter) { filter in
                    HStack {
                        Image(systemName: filter.selected ? "checkmark.square.fill" : "square")
                            .font(.footnote)
                        Text(filter.name.capitalizedWord)
                        Spacer()
                    }
                    .font(.subheadline)
                    .padding([.leading, .trailing])
                    .foregroundStyle(Color("FilterList"))
                    .contentShape(Rectangle())
                    .onTapGesture {
                        filterViewModel.volumeFilterRowTapped(filterRow: filter)
                    }
                }
                HStack {
                    Text("Features")
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(Color("TitleFont"))
                    Spacer()
                }
                .padding([.top, .trailing])
                ForEach(filterViewModel.featureFilter) { filter in
                    HStack {
                        Image(systemName: filter.selected ? "checkmark.square.fill" : "square")
                            .font(.footnote)
                        Text(filter.name.capitalizedWord)
                        Spacer()
                    }
                    .font(.subheadline)
                    .padding([.top, .leading, .trailing])     
                    .foregroundStyle(Color("FilterList"))
                    .contentShape(Rectangle())
                    .onTapGesture {
                        filterViewModel.featureFilterRowTapped(filterRow: filter)
                    }
                }
            }
            .padding()
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 0.5)
                .foregroundStyle(Color(.systemGray4))
                .shadow(color: Color("FilterList").opacity(0.4), radius:2)
        }
        .padding(.horizontal)
    }
}

struct CollapsedFilterView: View {
    var body: some View {
        HStack {
            Text("Choose filters")
                .padding()
                .font(.subheadline)
                .foregroundStyle(Color("TextColor").opacity(0.7))
            Spacer()
            Image(systemName: "chevron.down")
                .padding()
                .foregroundStyle(Color("TextColor"))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 0.5)
                .foregroundStyle(Color(.systemGray4))
                .shadow(color: Color("TextColor").opacity(0.4), radius:2)
        }
        .padding(.horizontal)
    }
}

#Preview {
    SearchView(show : .constant(false))
        .environmentObject(FilterViewModel())
}
