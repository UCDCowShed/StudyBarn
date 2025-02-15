//
//  AddSubAreaView.swift
//  StudyBarn
//
//  Created by JinLee on 2/28/24.
//

import SwiftUI

// ONLY FOR ADMINS

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
    @State private var bougie: Bool = false
    @State private var lecture: Bool = false
    @State private var independent: Bool = false
    @State private var bustling: Bool = false
    @State private var grassy: Bool = false

    
    private func addNewSubArea() {
        if let areaId {
            Task {
                let floorInt = Int(self.floor) ?? 0
                let area = viewModel.areasHashmap[areaId]
                
                try await addSubAreaViewModel.addNewSubArea(subAreaName: self.subAreaName, areaId: areaId, floor: floorInt, outdoors: self.outdoors, groupStudy: self.groupStudy, microwave: self.microwave, printer: self.printer, dining: self.dining, outlets: self.outlets, computers: self.computers, bougie: self.bougie, lecture: self.lecture, independent: self.independent, bustling: self.bustling, grassy: self.grassy, areaModel: area)
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
                
                // get bougie
                HStack{
                    Text("\(bougie ? "True" : "False")")
                    Spacer()
                    Button{
                        bougie = !bougie
                    } label: {
                        Text("Toggle bougie")
                    }
                }
               
                // get lecture
                HStack{
                    Text("\(lecture ? "True" : "False")")
                    Spacer()
                    Button{
                        lecture = !lecture
                    } label: {
                        Text("Toggle lecture")
                    }
                }
                
                // get indepedent
                HStack{
                    Text("\(independent ? "True" : "False")")
                    Spacer()
                    Button{
                        independent = !independent
                    } label: {
                        Text("Toggle independent")
                    }
                }
                
                // get bustling
                HStack{
                    Text("\(bustling ? "True" : "False")")
                    Spacer()
                    Button{
                        bustling = !bustling
                    } label: {
                        Text("Toggle bustling")
                    }
                }
                
                // get grassy
                HStack{
                    Text("\(grassy ? "True" : "False")")
                    Spacer()
                    Button{
                        grassy = !grassy
                    } label: {
                        Text("Toggle grassy")
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
