//
//  AddImageView.swift
//  StudyBarn
//
//  Created by Ann Yip on 3/5/24.
//

import SwiftUI
import PhotosUI

struct AddImageView: View {
    @StateObject private var addImageViewModel = AddImageViewModel()
    @State private var selectedItem: PhotosPickerItem? = nil
    let areaID: String?
    let isArea: Bool?
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                Text("Select a photo")
            }
        }
        .onChange(of: selectedItem) { oldValue, newValue in
            if let newValue, let areaID, let isArea {
                addImageViewModel.addImage(item: newValue, areaID: areaID, isArea: isArea)
            }
        }
    }
}

#Preview {
    AddImageView(areaID: "xQkbeSLfZVUNxCm9DCa5", isArea: true)
}
