//
//  AdminView.swift
//  StudyBarn
//
//  Created by JinLee on 2/28/24.
//

import SwiftUI
import PhotosUI

struct AdminView: View {
    
    
    func addImage(item: PhotosPickerItem) {
        Task {
            guard let data = try await item.loadTransferable(type: Data.self) else {
                print("FAILED")
                return
            }
            let (path, name) = try await ImageManager.shared.saveImage(data: data)
            print("SUCCESS")
            print(path)
            print(name)
        }
    }
    
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
            NavigationLink {
                AddImageView()
            } label : {
                Label("Add Photos", systemImage: "photo")
            }
        }
        .foregroundColor(.black)

    }
}

#Preview {
    NavigationStack {
        AdminView()
    }
}
