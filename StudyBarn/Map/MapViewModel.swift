//
//  MapViewModel.swift
//  StudyBarn
//
//  Created by JinLee on 3/11/24.
//

import Foundation

@MainActor
final class MapViewModel: ObservableObject {
    
    func checkIfLocationServiceIsEnabled() {
        MapManager.shared.checkIfLocationServiceIsEnabled()
    }
}
