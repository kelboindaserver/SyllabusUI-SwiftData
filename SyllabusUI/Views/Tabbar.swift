//
//  Tabbar.swift
//  SyllabusUI
//
//  Created by Sadan Efe Oz on 30.07.2023.
//

import SwiftUI

struct Tabbar: View {
    @State private var selectedTab = "tab1"
    let notify = NotificationHandler()
    var body: some View {
        TabView(selection: $selectedTab) {
            ContentView().tabItem {
                Image(systemName: "note.text")
                Text("Syllabus")
            }.tag("tab1")
            ExamSchedule().tabItem {
                
                Image(systemName: "folder.fill")
                    
                Text("Exam Schedule")
            }.tag("tab2")

        }.onAppear {
            let appearance = UITabBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = UIColor(Color.black.opacity(0.1))
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
            notify.askPerm()
        }
    }
}

#Preview {
    Tabbar()
        
}
