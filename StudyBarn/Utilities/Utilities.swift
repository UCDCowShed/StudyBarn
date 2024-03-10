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
    
    private func setAmPm(hours: HourMin) -> String {
        let hour = hours.hour >= 12 ? String(hours.hour == 12 ? hours.hour : hours.hour - 12) + "PM" : String(hours.hour) + "AM"
        return hour
    }
    
    func formatHours (openHour: HourMin?, closeHour: HourMin?) -> String {
        guard let openHours = openHour else { return "Closed"}
        guard let closeHours = closeHour else { return "Closed"}
        
        // Set Minute
        let openMinute = openHours.minute == 0 ? "00" : String(openHours.minute)
        let closeMinute = closeHours.minute == 0 ? "00" : String(closeHours.minute)
        
        let openHour = self.setAmPm(hours: openHours)
        let closeHour = self.setAmPm(hours: closeHours)
        
        return openHour + ":" + openMinute + " - " + closeHour + ":" + closeMinute
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
