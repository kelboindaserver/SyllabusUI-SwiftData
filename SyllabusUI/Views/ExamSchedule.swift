//
//  ExamSchedule.swift
//  SyllabusUI
//
//  Created by Sadan Efe Oz on 30.07.2023.
//

import SwiftUI
import SwiftData

struct ExamSchedule: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var exams: [Exam]
    func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy , E"
        return dateFormatter.string(from: date)
    }
    var sortedExams: [Exam] {
        return exams.sorted { $0.examDate < $1.examDate }
    }
    var body: some View {
        NavigationView{
            ZStack{
                RoundedRectangle(cornerRadius: 25)
                    .blur(radius: 250)
                    .foregroundColor(Color(hue: 0.474, saturation: 0.624, brightness: 0.962, opacity: 0.726))
                    .offset(x: -270)
                RoundedRectangle(cornerRadius: 25)
                    .blur(radius: 250)
                    .foregroundColor(Color(hue: 0.356, saturation: 1.0, brightness: 1.0, opacity: 0.602))
                    .offset(x: 300)
                VStack(alignment: .leading){
                    Text("Exam Schedule")
                        .font(.system(size: 30,weight: .bold))
                        .padding(.horizontal, 30)
                    List{
                        ForEach(sortedExams){ exam in
                            Section(header: Text(formattedDate(date:exam.examDate))
                                .fontWeight(.bold)
                                .font(.system(size: 22))) {
                                    
                                    HStack{
                                        Text(exam.examName)
                                            .padding()
                                            .fontWeight(.bold)
                                            .font(.system(size: 20))
                                        Spacer()
                                        Text(exam.examTime)
                                            .padding()
                                            .fontWeight(.light)
                                            .font(.system(size: 15))
                                    }
                                    
                                }
                            
                        } .onDelete(perform: deleteItems)
                    }.scrollContentBackground(.hidden)
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
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(sortedExams[index])
            }
        }
    }
}

#Preview {
    ExamSchedule()
        .modelContainer(for: Exam.self, inMemory: true)
}
