//
//  ExamSchedule.swift
//  SyllabusUI
//
//  Created by Sadan Efe Oz on 30.07.2023.
//

import SwiftUI
import SwiftData
import PopupView

struct ExamSchedule: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) var colorScheme
    @Query private var exams: [Exam]
    @State private var showingPopup = false
    @State private var showingButton = true
    @State private var selectTime = 15
    @State private var times = [0,10,15,30,45,60,90,120]
    let funcs = Funcs()
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
                                            Button {
                                                exam.alertBool.toggle()
                                                if exam.alertBool{
                                                    showingPopup = true
                                                }
                                            } label: {
                                                Image(systemName: exam.alertBool ? "alarm.fill" : "alarm")
                                                    .contentTransition(.symbolEffect(.replace.offUp))
                                            }
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
                                
                            } .onDelete(perform: deleteItems)
                        }.scrollContentBackground(.hidden)
                    }
                }
            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    NavigationLink(destination: addExam()) {
                        Image(systemName: "plus.circle.fill")
                    }
                    
                    
                    
                }
            } 
            .popup(isPresented: $showingPopup) {
                VStack{
                    Text("Select Time")
                        .cornerRadius(30.0)
                    Picker("", selection: $selectTime) {
                        ForEach(times , id: \.self){ time in
                            Text("\(time)")
                        }
                        

                    }
                    Button {
                        showingPopup = false
                        
                    } label: {
                        Text("Set Time")
                        Image(systemName: "plus")
                            
                    }
                }
                .padding(EdgeInsets(top: 37, leading: 24, bottom: 40, trailing: 24))
                .background(Color.black.cornerRadius(20))
                .padding(.horizontal, 40)
                
            }customize: {
                $0
                    .closeOnTap(false)
                    .backgroundColor(.black.opacity(0.7))
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
