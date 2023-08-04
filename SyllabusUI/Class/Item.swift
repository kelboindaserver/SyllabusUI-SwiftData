//
//  Item.swift
//  SyllabusUI
//
//  Created by Sadan Efe Oz on 30.07.2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var lessonName: String
    var lessonTime: String
    var day : String
    var id: String
    init(lessonName: String, lessonTime: String, day: String) {
        self.lessonName = lessonName
        self.lessonTime = lessonTime
        self.day = day
        self.id = UUID().uuidString
    }
}
