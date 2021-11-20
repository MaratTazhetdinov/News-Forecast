//
//  NotificationDelegate.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 15.11.2021.
//

import Foundation
import UserNotifications

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    public static let mapForecastModule = "mapForecastModule"
    
    public var router: RouterProtocol?
    
    private override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    static let shared = {
        return NotificationDelegate.init()
    }()
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if let module = response.notification.request.content.userInfo["module"] as? String,
           module == NotificationDelegate.mapForecastModule {
            self.router?.showMapForecast()
        }
    }
}
