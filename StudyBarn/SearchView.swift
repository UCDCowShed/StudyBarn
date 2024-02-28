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
    
    struct Item: Identifiable, Hashable {
        let item: String
        let id = UUID()
    }
    
    struct Selection: Identifiable, Hashable {
        let category: String
        let items: [Item]
        let id = UUID()
    }
    
    let selections: [Selection] = [
        Selection(category: "Atmosphere",
                  items: [Item(item: "Outdoors"),
                          Item(item: "Busy "),
                          Item(item: "Indoors"),
                          Item(item: "Moody")]),
        Selection(category: "Volume",
                  items: [Item(item: "Group Study"),
                          Item(item: "Quiet Study"),
                          Item(item: "Silent Study")]),
        Selection(category: "Amenities",
                  items: [Item(item: "Microwave"),
                          Item(item: "Food vendor"),
                          Item(item: "Printing"),
                          Item(item: "Charger")])
    ]
    
    @State var multiSelection = Set<UUID>()
    @State var extend_filter : Bool = false
    @State var search: String = ""
    
    var body: some View {
        VStack {
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
            // Collapsed filter
            if extend_filter {
                ExtendedFilterView()
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
    var body: some View {
        VStack {
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
            .padding(.horizontal)
//            HStack {
//            }
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 0.5)
                .foregroundStyle(Color(.systemGray4))
                .shadow(color: .black.opacity(0.4), radius:2)
        }
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
    SearchView(show : .constant(false))
}
