//
//  AddSubAreaView.swift
//  StudyBarn
//
//  Created by JinLee on 2/28/24.
//

import SwiftUI

struct AddSubAreaView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var viewModel: SelectViewModel
    let areaId: String?
    @StateObject var addSubAreaViewModel = AddSubAreaViewModel()
    
    // All Default values are false
    @State private var subAreaName: String = ""
    @State private var floor: String = ""
    @State private var outdoors: Bool = false
    @State private var groupStudy: Bool = false
    @State private var microwave: Bool = false
    @State private var printer: Bool = false
    @State private var dining: Bool = false
    @State private var outlets: Bool = false
    @State private var computers: Bool = false

    
    private func addNewSubArea() {
        if let areaId {
            Task {
                let floorInt = Int(self.floor) ?? 0
                let area = viewModel.areasHashmap[areaId]
                
                try await addSubAreaViewModel.addNewSubArea(subAreaName: self.subAreaName, areaId: areaId, floor: floorInt, outdoors: self.outdoors, groupStudy: self.groupStudy, microwave: self.microwave, printer: self.printer, dining: self.dining, outlets: self.outlets, computers: self.computers, areaModel: area)
            }
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
                // Get computers
                HStack{
                    Text("\(outlets ? "True" : "False")")
                    Spacer()
                    Button{
                        outlets = !outlets
                    } label: {
                        Text("Toggle Outlets")
                    }
                }
                // Get computers
                HStack{
                    Text("\(computers ? "True" : "False")")
                    Spacer()
                    Button{
                        computers = !computers
                    } label: {
                        Text("Toggle Computers")
                    }
                }
                // Get foodVendor
                HStack{
                    Text("\(dining ? "True" : "False")")
                    Spacer()
                    Button{
                        dining = !dining
                    } label: {
                        Text("Toggle Dining")
                    }
                }
               
                
                // Submit form button
                Button {
                    addNewSubArea()
                    self.presentationMode.wrappedValue.dismiss()
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
        AddSubAreaView(areaId: "")
            .environmentObject(SelectViewModel())
    }
}
