//
//  AddAreaView.swift
//  StudyBarn
//
//  Created by JinLee on 2/28/24.
//

import SwiftUI

// ONLY FOR ADMINS

struct AddAreaView: View {
    
    @StateObject var addAreaViewModel = AddAreaViewModel()
    
    @State private var areaName: String = ""
    @State private var openHourMon: Date = Date()
    @State private var closeHourMon: Date = Date()
    @State private var openHourTue: Date = Date()
    @State private var closeHourTue: Date = Date()
    @State private var openHourWed: Date = Date()
    @State private var closeHourWed: Date = Date()
    @State private var openHourThr: Date = Date()
    @State private var closeHourThr: Date = Date()
    @State private var openHourFri: Date = Date()
    @State private var closeHourFri: Date = Date()
    @State private var openHourSat: Date = Date()
    @State private var closeHourSat: Date = Date()
    @State private var openHourSun: Date = Date()
    @State private var closeHourSun: Date = Date()
    @State private var latitude: String = ""
    @State private var longitude: String = ""
    
    private func addNewArea() {
        let dates = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        
        let openHours = [dates[0]: openHourMon, dates[1]: openHourTue, dates[2]: openHourWed, dates[3]: openHourThr, dates[4]: openHourFri, dates[5]: openHourSat, dates[6]: openHourSun]
        
        let closeHours = [dates[0]: closeHourMon, dates[1]: closeHourTue, dates[2]: closeHourWed, dates[3]: closeHourThr, dates[4]: closeHourFri, dates[5]: closeHourSat, dates[6]: closeHourSun]
        Task {
            try await addAreaViewModel.addNewArea(areaName: areaName, openHours: openHours, closeHours: closeHours, latitude: latitude, longitude: longitude)
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
                // Get Open Hours & Close Hours
                DatePicker("Open Mon Hours", selection: $openHourMon, displayedComponents: .hourAndMinute)
                DatePicker("Close Mon Hours", selection: $closeHourMon, displayedComponents: .hourAndMinute)
                DatePicker("Open Tue Hours", selection: $openHourTue, displayedComponents: .hourAndMinute)
                DatePicker("Close Tue Hours", selection: $closeHourTue, displayedComponents: .hourAndMinute)
                DatePicker("Open Wed Hours", selection: $openHourWed, displayedComponents: .hourAndMinute)
                DatePicker("Close Wed Hours", selection: $closeHourWed, displayedComponents: .hourAndMinute)
                DatePicker("Open Thr Hours", selection: $openHourThr, displayedComponents: .hourAndMinute)
                DatePicker("Close Thr Hours", selection: $closeHourThr, displayedComponents: .hourAndMinute)
                DatePicker("Open Fri Hours", selection: $openHourFri, displayedComponents: .hourAndMinute)
                DatePicker("Close Fri Hours", selection: $closeHourFri, displayedComponents: .hourAndMinute)
                DatePicker("Open Sat Hours", selection: $openHourSat, displayedComponents: .hourAndMinute)
                DatePicker("Close Sat Hours", selection: $closeHourSat, displayedComponents: .hourAndMinute)
                DatePicker("Open Sun Hours", selection: $openHourSun, displayedComponents: .hourAndMinute)
                DatePicker("Close Sun Hours", selection: $closeHourSun, displayedComponents: .hourAndMinute)
                // Get latitude
                TextField(
                    "Latitude",
                    text: $latitude
                )
                // Get longitude
                TextField(
                    "Longitude",
                    text: $longitude
                )
                
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
