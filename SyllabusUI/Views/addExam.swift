//
//  addExam.swift
//  SyllabusUI
//
//  Created by Sadan Efe Oz on 30.07.2023.
//

import SwiftUI
import SwiftData

struct addExam: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    @Query private var exams: [Exam]
    @State private var examN = ""
    @State private var id = UUID().uuidString
    @State private var examD = Date()
    @State private var examT = Date()
    @FocusState private var emailBool : Bool
    @State private var showAlert = false
    let notify = NotificationHandler()
    let funcs = Funcs()
    var ExamT: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: examT)
    }
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .blur(radius: 250)
                .foregroundColor(Color(hue: 0.309, saturation: 0.652, brightness: 0.655, opacity: 0.602))
                .offset(x: -270)
            RoundedRectangle(cornerRadius: 25)
                .blur(radius: 250)
                .foregroundColor(Color(hue: 0.594, saturation: 0.696, brightness: 0.75, opacity: 0.622))
                .offset(x: 300)
            
            VStack{
                TextField("Exam", text: $examN)
                    .focused($emailBool)
                        .textContentType(.emailAddress)
                        .autocapitalization(.none)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(emailBool ? .blue:.gray, lineWidth: 2)
                        )
                        .padding([.top,.trailing,.leading] , 30)
                        .font(.system(.headline, design: .rounded,weight: .bold))
                VStack{
                    Text("Exam Time:")
                    DatePicker("", selection: $examD,displayedComponents: [.date,.hourAndMinute])
                        .labelsHidden()
                }
                Button(action:{
                    if examN.isEmpty{
                        showAlert = true
                    }else{
                        presentationMode.wrappedValue.dismiss()
                        addItem()
                    }
                }, label: {
                    Text("Add Exam")
                }) .foregroundColor(.black)
                    .padding()
                    .background(
                        Color(hue: 0.381, saturation: 0.577, brightness: 0.818)
                    )
                    .cornerRadius(25)
                    .padding(.top, 30)
                    .buttonStyle(.automatic)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Error"),
                            message: Text("Exam Name can not empty !"),
                            dismissButton: .default(Text("OK"))
                        )
                    }
            }
            
        }
        
    }
    private func addItem() {
        withAnimation {
            @Bindable var newItem = Exam(examName: examN, examDate: examD, examTime: ExamT,id: id)
            modelContext.insert(newItem)
            notify.sendNotification(date: funcs.subtractMinutes(from: examD, minutes: 15), type: "exam",day: 0,hour: 0,minute: 0, title: "Syllabus UI", body: "You have \(examN) Exam today at \(funcs.getFormattedTime(date: examD))", id: id)
        }
    }
}

#Preview {
    addExam()
}
