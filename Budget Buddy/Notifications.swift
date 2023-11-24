//
//  Notifications.swift
//  Budget Buddy
//
//  Created by Christian Kaden Lim on 23/11/23.
//

import Foundation
import UserNotifications

let center = UNUserNotificationCenter.current()

func requestAuth() {
    center.requestAuthorization(options: [.alert, .sound, .badge, .provisional]) { granted, error in
        
        if let error = error {
            print(error)
        }
        
        sendNotifications(title: "Good Morning!", subtitle: "Open the app to log your data and boost your streak!")
    }
}

//Good Morning!
//Open the app to log your data and boost your streak!

func sendNotifications(title: String, subtitle: String) {
    center.getNotificationSettings { settings in
        guard (settings.authorizationStatus == .authorized) ||
                (settings.authorizationStatus == .provisional) else { return }
        
        if settings.alertSetting == .enabled {
            notification(title: title, subtitle: subtitle, sound: false)
        } else {
            notification(title: title, subtitle: subtitle, sound: true)
        }
    }
}

func notification(title: String, subtitle: String, sound: Bool) {
    let content = UNMutableNotificationContent()
    content.title = subtitle
    content.subtitle = subtitle
    if (sound) {
        content.sound = UNNotificationSound.default
    }
    
    var date = DateComponents()
    date.hour = 9
    let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
    
    let uuidString = UUID().uuidString
    let request = UNNotificationRequest(identifier: uuidString,
                                        content: content, trigger: trigger)
    
    let notificationCenter = UNUserNotificationCenter.current()
    notificationCenter.add(request) { (error) in
        if error != nil {
            print(error!)
        }
    }
}
