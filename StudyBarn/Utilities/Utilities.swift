//
//  Utilities.swift
//  StudyBarn
//
//  Created by JinLee on 2/22/24.
//

import Foundation
import UIKit

final class Utilities {
    static let shared = Utilities()
    private init() {}
    
    // Get Top View Controller for google auth sign in
    @MainActor
    func topViewController(controller: UIViewController? = nil) -> UIViewController? {
        let controller = controller ?? UIApplication.shared.keyWindow?.rootViewController
        
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    func getCurrentDate() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"

        let dayString = dateFormatter.string(from: currentDate)
        
        return dayString
    }
    
    func getCurrentTime() -> HourMin {
        let curDate = Date()
        let hour = Calendar.current.component(.hour, from: curDate)
        let minute = Calendar.current.component(.minute, from: curDate)
        
        return HourMin(hour: hour, minute: minute)
    }
}

extension String {
    var doubleValue: Double {
        return Double(self) ?? 0
    }
    
    var capitalizedWord: String {
        let firstLetter = self.prefix(1).capitalized
        let remainingLetters = self.dropFirst().lowercased()
        
        return firstLetter + remainingLetters
    }
    
}
