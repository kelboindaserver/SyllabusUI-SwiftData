//
//  Tabbar.swift
//  SyllabusUI
//
//  Created by Sadan Efe Oz on 30.07.2023.
//

import SwiftUI
import AnimatedTabBar

struct Tabbar: View {
    @State private var selectedTab = "tab1"
    @State private var selectedIndex = 0
    @State private var prevSelectedIndex = 0
    @Environment(\.colorScheme) var colorScheme
    let notify = NotificationHandler()
    var body: some View {
        ZStack{
            if selectedIndex == 0 {
                            ContentView()
                    .transition(.opacity)
                        } else if selectedIndex == 1 {
                            ExamSchedule()
                                .transition(.opacity)
                        }
           AnimatedTabBar(selectedIndex: $selectedIndex){
               Button(action: {
                   withAnimation {
                               selectedIndex = 0
                           }
               }, label: {
                   VStack{
                       Image(systemName: selectedIndex == 0 ? "books.vertical.fill" : "books.vertical")
                           .font(.system(size: 20,weight: .semibold))
                           .contentTransition(.symbolEffect(.replace.offUp))
                   }
                  
               })
               Button(action: {
                   withAnimation {
                              selectedIndex = 1
                          }
               }, label: {
                   VStack{
                       Image(systemName: selectedIndex == 1 ? "list.bullet.clipboard.fill" : "clipboard")
                           .font(.system(size: 20,weight: .semibold))
                           .contentTransition(.symbolEffect(.replace.offUp))
                       
                   }
                   
               })
           }
               .cornerRadius(20)
               .selectedColor(colorScheme == .dark ? .white : .black)
               .unselectedColor(colorScheme == .dark ? .gray : Color(red: 0, green: 0, blue: 0, opacity: 0.5))
               .ballColor(colorScheme == .dark ? .white : .black)
               .verticalPadding(20)
               .ballTrajectory(.teleport)
               .ballAnimation(.interpolatingSpring(stiffness: 230, damping: 50))
               .indentAnimation(.easeOut(duration: 0.3))
               .barColor(colorScheme == .dark ? Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.2) : Color(red: 0, green: 0, blue: 0, opacity: 0.2))
               .ignoresSafeArea()
               .padding(.horizontal,20)
               .padding(.bottom,10)
               .containerRelativeFrame(.vertical, alignment: .bottom)
        }
            
                
        }
//                TabView(selection: $selectedTab) {
//                    ContentView().tabItem {
//                        Image(systemName: "note.text")
//                        Text("Syllabus")
//                    }.tag("tab1")
//                    ExamSchedule().tabItem {
//                        Image(systemName: "folder.fill")
//                        Text("Exam Schedule")
//                    }.tag("tab2")
//                }.onAppear {
//                    let appearance = UITabBarAppearance()
//                    appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
//                    appearance.backgroundColor = UIColor(Color.black.opacity(0.1))
//                    UITabBar.appearance().standardAppearance = appearance
//                    UITabBar.appearance().scrollEdgeAppearance = appearance
//                    notify.askPerm()
//                }
    }


#Preview {
    Tabbar()
    
}
