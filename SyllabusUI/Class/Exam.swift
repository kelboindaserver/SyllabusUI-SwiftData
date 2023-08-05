//
//  File.swift
//  SyllabusUI
//
//  Created by Sadan Efe Oz on 30.07.2023.
//

import Foundation
import SwiftData

@Model
final class Exam {
    var examName : String
    var examDate : Date
    var examTime : String
    var id : String
    init(examName: String, examDate: Date, examTime: String,id : String) {
        self.examName = examName
        self.examDate = examDate
        self.examTime = examTime
        self.id = id
    }
}
