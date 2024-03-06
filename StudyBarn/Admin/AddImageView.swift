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
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                Text("Select a photo")
            }
        }
        .onChange(of: selectedItem) { oldValue, newValue in
            print("Selected image")
            if let newValue {
                addImageViewModel.addImage(item: newValue)
            }
        }
    }
}

#Preview {
    AddImageView()
}
