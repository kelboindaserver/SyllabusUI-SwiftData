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
    func sendNotification(date: Date,type:String,timeInterval: Double = 10 , title: String,body: String){
        var trigger = UNNotificationTrigger?
    }
}
