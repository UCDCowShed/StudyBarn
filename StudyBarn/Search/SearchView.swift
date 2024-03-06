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
    @Binding var areas: [AreaModel]
    @StateObject var filterViewModel = FilterViewModel()
    
    @State var multiSelection = Set<UUID>()
    @State var extend_filter : Bool = false
    @State var search: String = ""
    
    var body: some View {
        VStack {
            // Search Bar
            VStack(alignment: .leading){
                Text("")
                    .font(.title2)
                    .fontWeight(.semibold)
                HStack {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.small)
                    TextField("Search", text: $search)
                        .font(.subheadline)
                }
                .frame(height: 45)
                .padding(.horizontal)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 0.5)
                        .foregroundStyle(Color(.systemGray4))
                        .shadow(color: .black.opacity(0.4), radius:2)
                }
            }
            .padding()
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .shadow(radius: 10)
            
            // Determine Collapsing Filter View
            if extend_filter {
                ExtendedFilterView()
                    .environmentObject(filterViewModel)
                    .onTapGesture {
                        extend_filter.toggle()
                    }
            } else {
                CollapsedFilterView()
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
                    .foregroundStyle(.black.opacity(0.8))
                }
                Spacer()
                
                // Search button
                Button {
                    withAnimation(.snappy) {
                        // search
                        // areas = await filterViewModel.getFilteredAreas()
                        show.toggle()
                    }
                } label: {
                    HStack {
                        Text("Search")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundStyle(.black.opacity(0.8))
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
                    .foregroundStyle(.gray)
                Spacer()
                Image(systemName: "chevron.up")
                    .padding()
                    .foregroundStyle(.black)
            }
            VStack {
                HStack {
                    Text("Atmosphere")
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                ForEach(filterViewModel.atmosphereFilter) { filter in
                    HStack {
                        Image(systemName: filter.selected ? "checkmark.square.fill" : "square")
                            .font(.footnote)
                        Text(filter.name.capitalizedWord)
                        Spacer()
                    }
                    .font(.subheadline)
                    .padding(.horizontal)
                    .foregroundStyle(Color("FilterList"))
                    .contentShape(Rectangle())
                    .onTapGesture {
                        filterViewModel.atmoFilterRowTapped(filterRow: filter)
                    }
                }
                HStack {
                    Text("Volume Levels")
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                ForEach(filterViewModel.volumeFilter) { filter in
                    HStack {
                        Image(systemName: filter.selected ? "checkmark.square.fill" : "square")
                            .font(.footnote)
                        Text(filter.name.capitalizedWord)
                        Spacer()
                    }
                    .font(.subheadline)
                    .padding(.horizontal)
                    .foregroundStyle(Color("FilterList"))
                    .contentShape(Rectangle())
                    .onTapGesture {
                        filterViewModel.volumeFilterRowTapped(filterRow: filter)
                    }
                }
                HStack {
                    Text("Features")
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                ForEach(filterViewModel.featureFilter) { filter in
                    HStack {
                        Image(systemName: filter.selected ? "checkmark.square.fill" : "square")
                            .font(.footnote)
                        Text(filter.name.capitalizedWord)
                        Spacer()
                    }
                    .font(.subheadline)
                    .padding(.horizontal)
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
                .shadow(color: .black.opacity(0.4), radius:2)
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
                .foregroundStyle(.gray)
            Spacer()
            Image(systemName: "chevron.down")
                .padding()
                .foregroundStyle(.black)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 0.5)
                .foregroundStyle(Color(.systemGray4))
                .shadow(color: .black.opacity(0.4), radius:2)
        }
        .padding(.horizontal)
    }
}

#Preview {
    SearchView(show : .constant(false), areas: .constant([AreaModel(areaId: "temp", name: "temp", rating: 0.0, images: ["temp/url"], openHour: HourMin(hour: 2, minute: 2), closeHour: HourMin(hour: 2, minute: 2), latitude: 100.0, longitude: -100.0)]))
        .environmentObject(FilterViewModel())
}
