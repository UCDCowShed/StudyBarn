//
//  AddSubAreaView.swift
//  StudyBarn
//
//  Created by JinLee on 2/28/24.
//

import SwiftUI

struct AddSubAreaView: View {
    
    @StateObject var addSubAreaViewModel = AddSubAreaViewModel()
    
    // All Default values are false
    @State private var subAreaName: String = ""
    @State private var areaId: String = ""
    @State private var floor: String = ""
    @State private var outdoors: Bool = false
    @State private var groupStudy: Bool = false
    @State private var microwave: Bool = false
    @State private var printer: Bool = false
    @State private var food: Bool = false
    @State private var outlets: Bool = false

    
    private func addNewSubArea() {
        Task {
            let floorInt = Int(self.floor) ?? 0
            
            try await addSubAreaViewModel.addNewSubArea(subAreaName: self.subAreaName, areaId: self.areaId, floor: floorInt, outdoors: self.outdoors, groupStudy: self.groupStudy, microwave: self.microwave, printer: self.printer, food: self.food, outlets: self.outlets)
        }
    }
    
    var body: some View {
        VStack {
            Form {
                // Get SubAreaName
                TextField(
                    "SubArea Name",
                    text: $subAreaName
                )
                // Get areaId
                TextField(
                    "Area Id",
                    text: $areaId
                )
                // Get floor
                TextField(
                    "Floor Num",
                    text: $floor
                )
                .keyboardType(.numberPad)
                // Get outdoors
                HStack{
                    Text("\(outdoors ? "True" : "False")")
                    Spacer()
                    Button{
                        outdoors = !outdoors
                    } label: {
                        Text("Toggle Outdoors")
                    }
                }
                // Get groupStudy
                HStack{
                    Text("\(groupStudy ? "True" : "False")")
                    Spacer()
                    Button{
                        groupStudy = !groupStudy
                    } label: {
                        Text("Toggle GroupStudy")
                    }
                }
                // Get microwave
                HStack{
                    Text("\(microwave ? "True" : "False")")
                    Spacer()
                    Button{
                        microwave = !microwave
                    } label: {
                        Text("Toggle Microwave")
                    }
                }
                // Get printer
                HStack{
                    Text("\(printer ? "True" : "False")")
                    Spacer()
                    Button{
                        printer = !printer
                    } label: {
                        Text("Toggle Printer")
                    }
                }
                // Get charger
                HStack{
                    Text("\(outlets ? "True" : "False")")
                    Spacer()
                    Button{
                        outlets = !outlets
                    } label: {
                        Text("Toggle Outlets")
                    }
                }
               
                
                // Submit form button
                Button {
                    addNewSubArea()
                } label: {
                    HStack {
                        Spacer()
                        Text("Add New SubArea button")
                            .padding()
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle("Add New SubArea")
    }
}

#Preview {
    NavigationStack {
        AddSubAreaView()
    }
}
