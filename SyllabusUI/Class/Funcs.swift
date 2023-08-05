//
//  Funcs.swift
//  SyllabusUI
//
//  Created by Şadan Efe Öz on 5.08.2023.
//

import Foundation
class Funcs {
    func getFormattedTime(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: date)
        }
    func convertToHourAndMinute(_ timeString: String) -> (hour: Int, minute: Int)? {
        let timeComponents = timeString.components(separatedBy: " - ")
        guard let startTimeString = timeComponents.first else { return nil }
        let timeParts = startTimeString.components(separatedBy: ":")
        
        guard timeParts.count == 2,
              let hour = Int(timeParts[0]),
              let minute = Int(timeParts[1]) else { return nil }
        
        return (hour, minute)
    }
    func convertToHourAndMinuteAMPM(_ timeString: String) -> (hour: Int, minute: Int)? {
        let timeComponents = timeString.components(separatedBy: " - ")
        guard let startTimeString = timeComponents.first else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        guard let startDate = dateFormatter.date(from: startTimeString) else { return nil }
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: startDate)
        let minute = calendar.component(.minute, from: startDate)
        
        return (hour, minute)
    }
    func containsAMorPM(_ inputString: String) -> Bool {
        return inputString.range(of: "AM|PM", options: .regularExpression) != nil
    }
}
