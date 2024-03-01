//
//  AddAreaView.swift
//  StudyBarn
//
//  Created by JinLee on 2/28/24.
//

import SwiftUI

struct AddAreaView: View {
    
    @StateObject var addAreaViewModel = AddAreaViewModel()
    
    @State private var areaName: String = ""
    @State private var openHour: Date = Date()
    @State private var closeHour: Date = Date()
    @State private var latitude: String = ""
    @State private var longitude: String = ""
    
    private func addNewArea() {
        Task {
            try await addAreaViewModel.addNewArea(areaName: areaName, openHour: openHour, closeHour: closeHour, latitude: latitude, longitude: longitude)
        }
    }
    
    var body: some View {
        VStack {
            Form {
                // Get User Name
                TextField(
                    "Area Name",
                    text: $areaName
                )
                // Get Open Hours
                DatePicker("Open Hours", selection: $openHour, displayedComponents: .hourAndMinute)
                // Get Close Hours
                DatePicker("Close Hours", selection: $closeHour, displayedComponents: .hourAndMinute)
                // Get latitude
                TextField(
                    "Latitude",
                    text: $latitude
                )
                .keyboardType(.decimalPad)
                // Get longitude
                TextField(
                    "Longitude",
                    text: $longitude
                )
                .keyboardType(.decimalPad)
                
                // Submit form button
                Button {
                    addNewArea()
                } label: {
                    HStack {
                        Spacer()
                        Text("Add New Area button")
                            .padding()
                        Spacer()
                    }
                }
            }
            
            
        }
        .navigationTitle("Add New Area")
    }
}

#Preview {
    NavigationStack {
        AddAreaView()
    }
}
