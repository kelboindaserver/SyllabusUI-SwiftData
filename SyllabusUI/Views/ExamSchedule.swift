//
//  ExamSchedule.swift
//  SyllabusUI
//
//  Created by Sadan Efe Oz on 30.07.2023.
//

import SwiftUI
import SwiftData
import Combine

struct ExamSchedule: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) var colorScheme
    @Query private var exams: [Exam]
    @State private var showingPopup = false
    @State private var showingButton = true
    @State private var selectTime = ""
    @State private var times = [0,10,15,30,45,60,90,120]
    let funcs = Funcs()
    let notify = NotificationHandler()
    var sortedExams: [Exam] {
        return exams.sorted { $0.examDate < $1.examDate }
    }
    var body: some View {
        NavigationView{
            ZStack{
                RadialGradient(gradient: Gradient(colors: [Color(hue: 0.809, saturation: 0.652, brightness: 0.355, opacity: 0.602), colorScheme == .dark ? .black : .white]), center: .center, startRadius: 2, endRadius: 650)
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading){
                    Text("Exam Schedule")
                        .font(.system(size: 30,weight: .bold))
                        .padding(.horizontal, 30)
                    if exams.isEmpty{
                        ContentUnavailableView("Exam are empty", systemImage: "square.dashed",description: Text("Tap \(Image(systemName: "plus.circle.fill")) to create Exam"))
                    }else{
                        List{
                            ForEach(sortedExams){ exam in
                                Section(header: Text(funcs.formattedDate(date:exam.examDate))
                                    .fontWeight(.bold)
                                    .font(.system(size: 22))) {
                                        
                                        HStack{
                                            VStack{
                                                Button {
                                                    exam.alertBool.toggle()
                                                    if exam.alertBool{
                                                        showingPopup = true
                                                    }else{
                                                        funcs.cancelNotification(id: exam.id)
                                                    }
                                                } label: {
                                                    Image(systemName: exam.alertBool ? "alarm.fill" : "alarm")
                                                        .contentTransition(.symbolEffect(.replace.offUp))
                                                }
                                            }
                                            HStack{
                                                Text(exam.examName)
                                                    .padding()
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 20))
                                                Spacer()
                                                Text(funcs.getFormattedTime(date: exam.examDate))
                                                    .padding()
                                                    .fontWeight(.light)
                                                    .font(.system(size: 15))
                                            }
                                        }
                                        
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
                                            notify.sendNotification(date: funcs.subtractMinutes(from: exam.examDate, minutes: Int(selectTime) ?? 15), type: "exam",day: 0,hour: 0,minute: 0, title: "Syllabus UI", body: "You have \(exam.examName) Exam today at \(funcs.getFormattedTime(date: exam.examDate))", id: exam.id)
                                            if self.selectTime.isEmpty {
                                                self.selectTime = "15"
                                            }
                                        }
                                    }, message: {
                                        Text("How many minutes before notification should be sent?")
                                    })
                                
                            } .onDelete(perform: deleteItems)
                        }.scrollContentBackground(.hidden)
                    }
                }
            }.toolbar {
                ToolbarItem {
                    NavigationLink(destination: addExam()) {
                        Image(systemName: "plus.circle.fill")
                    }
                    
                    
                    
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(sortedExams[index])
                funcs.cancelNotification(id: exams[index].id)
            }
        }
    }
}

#Preview {
    ExamSchedule()
        .modelContainer(for: Exam.self, inMemory: true)
}
