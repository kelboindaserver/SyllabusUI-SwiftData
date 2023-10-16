//
//  ContentView.swift
//  SyllabusUI
//
//  Created by Sadan Efe Oz on 30.07.2023.
//

import SwiftUI
import SwiftData
import Combine

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedIndex = 0
    @Query private var items: [Item]
    @State private var showingPopup = false
    @State private var showingButton = true
    @State private var alertBool = true
    @State private var selectTime = ""
    @State private var times = [0,10,15,30,45,60,90,120]
    let funcs = Funcs()
    var body: some View {
        NavigationView {
            ZStack{
                VStack(alignment: .leading){
                    Text("Syllabus")
                        .font(.system(size: 30,weight: .bold))
                        .padding(.horizontal, 30)
                    if items.isEmpty{
                        ContentUnavailableView("Lessons are Empty", systemImage: "square.dashed",description: Text("Tap \(Image(systemName: "plus.circle.fill")) to create Lesson"))
                    }else{
                        List {
                            Section(header: Text("MONDAY")
                                .fontWeight(.bold)
                                .font(.system(size: 22))) {
                                    ForEach(items) { item in
                                        if item.day == "Monday"{
                                            HStack{
                                                VStack{
                                                    Button {
                                                        alertBool.toggle()
                                                        if alertBool{
                                                            showingPopup = true
                                                        }else{
                                                            funcs.cancelNotification(id: item.id)
                                                        }
                                                    } label: {
                                                        Image(systemName: alertBool ? "alarm.fill" : "alarm")
                                                            .contentTransition(.symbolEffect(.replace.offUp))
                                                    }
                                                }
                                                Text(item.lessonName)
                                                    .padding()
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 20))
                                                Spacer()
                                                Text("\(item.lessonTime)")
                                                    .padding()
                                                    .fontWeight(.light)
                                                    .font(.system(size: 15))
                                            }.alert("Select Time", isPresented: $showingPopup, actions: {
                                                TextField("Default : 15", text: $selectTime)
                                                    .keyboardType(.numberPad)
                                                    .onReceive(Just(selectTime)) { newText in
                                                        let filtered = newText.filter { "0123456789".contains($0) }
                                                        if filtered != newText {
                                                            self.selectTime = filtered
                                                        }
                                                        if let number = Int(filtered), !(0...240).contains(number) {
                                                            self.selectTime = "240"
                                                        }
                                                        
                                                    }
                                                    .padding()
                                                Button("OK") {
                                                    
                                                    if self.selectTime.isEmpty {
                                                        self.selectTime = "15"
                                                    }
                                                }
                                            }, message: {
                                                Text("How many minutes before notification should be sent?")
                                            })
                                            
                                        }
                                        
                                    }
                                    .onDelete(perform: deleteItems)
                                }
                            Section(header: Text("TUESDAY")
                                .fontWeight(.bold)
                                .font(.system(size: 22))) {
                                    ForEach(items) { item in
                                        if item.day == "Tuesday"{
                                            HStack{
                                                VStack{
                                                    Button {
                                                        alertBool.toggle()
                                                        if alertBool{
                                                            showingPopup = true
                                                        }else{
                                                            funcs.cancelNotification(id: item.id)
                                                        }
                                                    } label: {
                                                        Image(systemName: alertBool ? "alarm.fill" : "alarm")
                                                            .contentTransition(.symbolEffect(.replace.offUp))
                                                    }
                                                }
                                                Text(item.lessonName)
                                                    .padding()
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 20))
                                                Spacer()
                                                Text("\(item.lessonTime)")
                                                    .padding()
                                                    .fontWeight(.light)
                                                    .font(.system(size: 15))
                                            }.alert("Select Time", isPresented: $showingPopup, actions: {
                                                TextField("Default : 15", text: $selectTime)
                                                    .keyboardType(.numberPad)
                                                    .onReceive(Just(selectTime)) { newText in
                                                        let filtered = newText.filter { "0123456789".contains($0) }
                                                        if filtered != newText {
                                                            self.selectTime = filtered
                                                        }
                                                        if let number = Int(filtered), !(0...240).contains(number) {
                                                            self.selectTime = "240"
                                                        }
                                                        
                                                    }
                                                    .padding()
                                                Button("OK") {
                                                    
                                                    if self.selectTime.isEmpty {
                                                        self.selectTime = "15"
                                                    }
                                                }
                                            }, message: {
                                                Text("How many minutes before notification should be sent?")
                                            })
                                            
                                            
                                        }
                                        
                                    }
                                    .onDelete(perform: deleteItems)
                                }
                            Section(header: Text("WEDNESDAY")
                                .fontWeight(.bold)
                                .font(.system(size: 22))) {
                                    ForEach(items) { item in
                                        if item.day == "Wednesday"{
                                            HStack{
                                                VStack{
                                                    Button {
                                                        alertBool.toggle()
                                                        if alertBool{
                                                            showingPopup = true
                                                        }else{
                                                            funcs.cancelNotification(id: item.id)
                                                        }
                                                    } label: {
                                                        Image(systemName: alertBool ? "alarm.fill" : "alarm")
                                                            .contentTransition(.symbolEffect(.replace.offUp))
                                                    }
                                                }
                                                Text(item.lessonName)
                                                    .padding()
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 20))
                                                Spacer()
                                                Text("\(item.lessonTime)")
                                                    .padding()
                                                    .fontWeight(.light)
                                                    .font(.system(size: 15))
                                            }.alert("Select Time", isPresented: $showingPopup, actions: {
                                                TextField("Default : 15", text: $selectTime)
                                                    .keyboardType(.numberPad)
                                                    .onReceive(Just(selectTime)) { newText in
                                                        let filtered = newText.filter { "0123456789".contains($0) }
                                                        if filtered != newText {
                                                            self.selectTime = filtered
                                                        }
                                                        if let number = Int(filtered), !(0...240).contains(number) {
                                                            self.selectTime = "240"
                                                        }
                                                        
                                                    }
                                                    .padding()
                                                Button("OK") {
                                                    
                                                    if self.selectTime.isEmpty {
                                                        self.selectTime = "15"
                                                    }
                                                }
                                            }, message: {
                                                Text("How many minutes before notification should be sent?")
                                            })
                                            
                                        }
                                        
                                    }
                                    .onDelete(perform: deleteItems)
                                }
                            Section(header: Text("THURSDAY")
                                .fontWeight(.bold)
                                .font(.system(size: 22))) {
                                    ForEach(items) { item in
                                        if item.day == "Thursday"{
                                            HStack{
                                                VStack{
                                                    Button {
                                                        alertBool.toggle()
                                                        if alertBool{
                                                            showingPopup = true
                                                        }else{
                                                            funcs.cancelNotification(id: item.id)
                                                        }
                                                    } label: {
                                                        Image(systemName: alertBool ? "alarm.fill" : "alarm")
                                                            .contentTransition(.symbolEffect(.replace.offUp))
                                                    }
                                                }
                                                Text(item.lessonName)
                                                    .padding()
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 20))
                                                Spacer()
                                                Text("\(item.lessonTime)")
                                                    .padding()
                                                    .fontWeight(.light)
                                                    .font(.system(size: 15))
                                            }.alert("Select Time", isPresented: $showingPopup, actions: {
                                                TextField("Default : 15", text: $selectTime)
                                                    .keyboardType(.numberPad)
                                                    .onReceive(Just(selectTime)) { newText in
                                                        let filtered = newText.filter { "0123456789".contains($0) }
                                                        if filtered != newText {
                                                            self.selectTime = filtered
                                                        }
                                                        if let number = Int(filtered), !(0...240).contains(number) {
                                                            self.selectTime = "240"
                                                        }
                                                        
                                                    }
                                                    .padding()
                                                Button("OK") {
                                                    
                                                    if self.selectTime.isEmpty {
                                                        self.selectTime = "15"
                                                    }
                                                }
                                            }, message: {
                                                Text("How many minutes before notification should be sent?")
                                            })
                                            
                                        }
                                        
                                    }
                                    .onDelete(perform: deleteItems)
                                }
                            Section(header: Text("FRIDAY")
                                .fontWeight(.bold)
                                .font(.system(size: 22))) {
                                    ForEach(items) { item in
                                        if item.day == "Friday"{
                                            HStack{
                                                VStack{
                                                    Button {
                                                        alertBool.toggle()
                                                        if alertBool{
                                                            showingPopup = true
                                                        }else{
                                                            funcs.cancelNotification(id: item.id)
                                                        }
                                                    } label: {
                                                        Image(systemName: alertBool ? "alarm.fill" : "alarm")
                                                            .contentTransition(.symbolEffect(.replace.offUp))
                                                    }
                                                }
                                                Text(item.lessonName)
                                                    .padding()
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 20))
                                                Spacer()
                                                Text("\(item.lessonTime)")
                                                    .padding()
                                                    .fontWeight(.light)
                                                    .font(.system(size: 15))
                                            }.alert("Select Time", isPresented: $showingPopup, actions: {
                                                TextField("Default : 15", text: $selectTime)
                                                    .keyboardType(.numberPad)
                                                    .onReceive(Just(selectTime)) { newText in
                                                        let filtered = newText.filter { "0123456789".contains($0) }
                                                        if filtered != newText {
                                                            self.selectTime = filtered
                                                        }
                                                        if let number = Int(filtered), !(0...240).contains(number) {
                                                            self.selectTime = "240"
                                                        }
                                                        
                                                    }
                                                    .padding()
                                                Button("OK") {
                                                    
                                                    if self.selectTime.isEmpty {
                                                        self.selectTime = "15"
                                                    }
                                                }
                                            }, message: {
                                                Text("How many minutes before notification should be sent?")
                                            })
                                            
                                        }
                                        
                                    }
                                    .onDelete(perform: deleteItems)
                                }
                            
                        }.scrollContentBackground(.hidden)
                    }
                }
                
            }.background(RadialGradient(gradient: Gradient(colors: [Color(hue: 0.609, saturation: 0.652, brightness: 0.655, opacity: 0.602), colorScheme == .dark ? .black : .white]), center: .center, startRadius: 2, endRadius: 650))
                .toolbar {
                    ToolbarItem {
                        NavigationLink(destination: addDers()) {
                            Image(systemName: "plus.circle.fill")
                        }
                    }
                }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
                funcs.cancelNotification(id: items[index].id)
            }
        }
    }
}
#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
    
}
