//
//  AddImageViewModel.swift
//  StudyBarn
//
//  Created by Ann Yip on 3/5/24.
//

import Foundation
import SwiftUI
import PhotosUI

@MainActor
final class AddImageViewModel: ObservableObject {
    func addImage(item: PhotosPickerItem) {
        Task {
            guard let data = try await item.loadTransferable(type: Data.self) else {
                return
            }
            let (path, name) = try await ImageManager.shared.saveImage(data: data)
            print("SUCCESS")
            print(path)
            print(name)
        }
    }
    
}
