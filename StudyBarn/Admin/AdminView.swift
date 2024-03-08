//
//  AdminView.swift
//  StudyBarn
//
//  Created by JinLee on 2/28/24.
//

import SwiftUI
import PhotosUI

struct AdminView: View {
    
    var body: some View {
        VStack (spacing: 40){
            NavigationLink {
                AddAreaView()
            } label: {
                Label("Add Area", systemImage: "folder")
            }
            
            NavigationLink {
                AddSubAreaView()
            } label: {
                Label("Add SubArea", systemImage: "folder")
            }
        }
        .foregroundStyle(Color("TextColor"))

    }
}

#Preview {
    NavigationStack {
        AdminView()
    }
}
