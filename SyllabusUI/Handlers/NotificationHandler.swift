//
//  NotificationHandler.swift
//  SyllabusUI
//
//  Created by Sadan Efe Oz on 1.08.2023.
//

import Foundation
import UserNotifications

class NotificationHandler {
    func askPerm(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { success, error in
            if success{
                print("success")
            }else if let error = error{
                print(error.localizedDescription)
            }
        }
    }
    func sendNotification (date: Date, type: String,day:Int,hour : Int,minute : Int, title:String, body: String,id:String) {
        var trigger: UNNotificationTrigger?
        if type == "exam" {
            let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: date)
            trigger = UNCalendarNotificationTrigger (dateMatching: dateComponents, repeats: false)	
        } else if type == "lesson" {
            var dateComponents = DateComponents()
            dateComponents.weekday = day
            dateComponents.hour = hour
            dateComponents.minute = minute
            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        let request = UNNotificationRequest(identifier:id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
