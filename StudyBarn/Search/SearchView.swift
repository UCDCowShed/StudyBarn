//
//  SearchButton.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/25/24.
//

import SwiftUI


struct SearchView: View {
    @Binding var show : Bool
    @StateObject var filterViewModel = FilterViewModel()
    @EnvironmentObject private var viewModel: SelectViewModel
    
    @State var multiSelection = Set<UUID>()
    @State var search: String = ""
    
    var body: some View {
        VStack {
            //Filter View
            FiltersView()
                .padding(.top, 20)
                .environmentObject(filterViewModel)
            
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
                                viewModel.loadNewAreas(newAreas: filteredAreas)
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
            .font(.custom("Futura", size: 18))
            .padding()
        }
    }
}

struct FiltersView: View {
    @EnvironmentObject var filterViewModel: FilterViewModel
    
    var body: some View {
        VStack{
            HStack {
                VStack(alignment: .leading, spacing: 7) {
                    Text("Choose Filters")
                        .font(.custom("Futura", size: 22))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color("TextColor"))
                    Text("Choosing 'none' will include all areas.")
                        .font(.custom("Futura", size: 14))
                        .foregroundStyle(.gray)
                }
                
                Spacer()
            }
            .padding()
            
            
            // Choose Filters
            VStack {
                HStack {
                    // Atmosphere
                    Button {
                        filterViewModel.atmoFilterRowTapped(filterRow: filterViewModel.atmosphereFilter[0])
                    } label: {
                        VStack {
                            Image(systemName: "tree.fill")
                            Text("Outdoors")
                        }
                        .modifier(FilterItem(isSelected: filterViewModel.atmosphereFilter[0].selected))
                        .modifier(FilterBox(isSelected: filterViewModel.atmosphereFilter[0].selected))
                    }
                    Spacer()
                    // Volume Levels
                    Button {
                        filterViewModel.volumeFilterRowTapped(filterRow: filterViewModel.volumeFilter[0])
                    } label: {
                        VStack {
                            Image(systemName: "speaker.wave.3.fill")
                            Text("GroupStudy")
                        }
                        .modifier(FilterItem(isSelected: filterViewModel.volumeFilter[0].selected))
                        .modifier(FilterBox(isSelected: filterViewModel.volumeFilter[0].selected))
                    }
                    Spacer()
                    // Microwave
                    Button {
                        filterViewModel.featureFilterRowTapped(filterRow: filterViewModel.featureFilter[0])
                    } label: {
                        VStack {
                            Image(systemName: "microwave.fill")
                            Text("Microwave")
                        }
                        .modifier(FilterItem(isSelected: filterViewModel.featureFilter[0].selected))
                        .modifier(FilterBox(isSelected: filterViewModel.featureFilter[0].selected))
                    }
                }
                .padding(.horizontal)
                HStack {
                    // Printer
                    Button {
                        filterViewModel.featureFilterRowTapped(filterRow: filterViewModel.featureFilter[1])
                    } label: {
                        VStack {
                            Image(systemName: "printer.fill")
                            Text("Printer")
                        }
                        .modifier(FilterItem(isSelected: filterViewModel.featureFilter[1].selected))
                        .modifier(FilterBox(isSelected: filterViewModel.featureFilter[1].selected))
                    }
                    Spacer()
                    // Outlets
                    Button {
                        filterViewModel.featureFilterRowTapped(filterRow: filterViewModel.featureFilter[2])
                    } label: {
                        VStack {
                            Image(systemName: "poweroutlet.type.b.square.fill")
                            Text("Outlets")
                        }
                        .modifier(FilterItem(isSelected: filterViewModel.featureFilter[2].selected))
                        .modifier(FilterBox(isSelected: filterViewModel.featureFilter[2].selected))
                    }
                    Spacer()
                    // Computers
                    Button {
                        filterViewModel.featureFilterRowTapped(filterRow: filterViewModel.featureFilter[3])
                    } label: {
                        VStack {
                            Image(systemName: "desktopcomputer")
                            Text("Computers")
                        }
                        .modifier(FilterItem(isSelected: filterViewModel.featureFilter[3].selected))
                        .modifier(FilterBox(isSelected: filterViewModel.featureFilter[3].selected))
                    }
                }
                .padding(.horizontal)
                HStack {
                    // Dining
                    Button {
                        filterViewModel.featureFilterRowTapped(filterRow: filterViewModel.featureFilter[4])
                    } label: {
                        VStack {
                            Image(systemName: "fork.knife")
                            Text("Dining")
                        }
                        .modifier(FilterItem(isSelected: filterViewModel.featureFilter[4].selected))
                        .modifier(FilterBox(isSelected: filterViewModel.featureFilter[4].selected))
                    }
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
    }
}

struct FilterItem: ViewModifier {
    var isSelected: Bool
    
    func body(content: Content) -> some View {
        content
            .frame(width:80, height: 80)
            .padding()
            .font(.custom("Futura", size: 14))
            .foregroundStyle(isSelected ? .blue : Color("FilterList"))
    }
}

struct FilterBox: ViewModifier {
    var isSelected: Bool
    
    func body(content: Content) -> some View {
        content
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 0.5)
                    .foregroundStyle(isSelected ? .blue : Color("FilterList"))
                    .shadow(color: Color(.systemGray4).opacity(0.4), radius:2)
            }
    }
}


#Preview {
    SearchView(show : .constant(false))
        .environmentObject(FilterViewModel())
}
