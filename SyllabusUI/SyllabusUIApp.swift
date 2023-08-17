//
//  SyllabusUIApp.swift
//  SyllabusUI
//
//  Created by Sadan Efe Oz on 30.07.2023.
//

import SwiftUI
import SwiftData
import TipKit

@main
struct SyllabusUIApp: App {

    var body: some Scene {
        WindowGroup {
            Tabbar()
        }
        .modelContainer(for: [Item.self,Exam.self])
    }
}
