//
//  NotificationViewModel.swift
//  NotADiary
//
//  Created by Pedro Augusto on 05/11/25.
//

import Foundation
import SwiftUI

class NotificationViewModel {
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Tudo pronto!")
            } else if let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func scheduleNotification(hour: Int, minute: Int) {
        var date = DateComponents()
        date.hour = hour
        date.minute = minute
        
        let content = UNMutableNotificationContent()
        content.title = "Lembrete de NotADiary"
        content.body = "Como foi seu dia?"
        content.sound = .default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: "notADiaryNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
