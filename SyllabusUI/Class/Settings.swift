//
//  Settings.swift
//  SyllabusUI
//
//  Created by Şadan Efe Öz on 9.08.2023.
//

import Foundation
import SwiftData

@Model
final class SettingsClass {
    var notificationTime : Int
    init(notificationTime: Int) {
        self.notificationTime = notificationTime
    }
}
