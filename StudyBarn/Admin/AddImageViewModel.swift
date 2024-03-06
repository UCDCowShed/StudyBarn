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
    func addImage(item: PhotosPickerItem, areaID: String, isArea: Bool) {
        Task {
            guard let data = try await item.loadTransferable(type: Data.self) else {
                return
            }
            let name = try await ImageManager.shared.saveImage(data: data, areaID: areaID, isArea: isArea)
            try await AreaManager.shared.addImage(areaId: areaID, name: name)
            print("SUCCESS")
            print(name)
        }
    }
}
