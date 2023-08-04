//
//  DersEkle.swift
//  SyllabusUI
//
//  Created by Sadan Efe Oz on 30.07.2023.
//

import SwiftUI
import SwiftData

struct DersEkle: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    @Query private var items: [Item]
    @State private var lessonN = ""
    @State private var lessonStart = Date()
    @State private var lessonEnd = Date()
    @State private var selection = "Monday"
    @State private var showAlert = false
    @State private var days = ["Monday","Tuesday","Wednesday","Thursday","Friday"]
    @FocusState private var emailBool : Bool
    var lessonSTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: lessonStart)
    }
    var lessonETime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: lessonEnd)
    }
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .blur(radius: 250)
                .foregroundColor(Color(hue: 0.58, saturation: 1.0, brightness: 1.0, opacity: 0.602))
                .offset(x: -270)
            RoundedRectangle(cornerRadius: 25)
                .blur(radius: 250)
                .foregroundColor(Color(hue: 0.918, saturation: 0.977, brightness: 1.0, opacity: 0.622))
                .offset(x: 300)
            
            VStack(alignment: .center){
                TextField("Lesson Name", text: $lessonN) {
                }.focused($emailBool)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(emailBool ? .blue:.gray, lineWidth: 2)
                    )
                    .padding([.top,.trailing,.leading] , 30)
                    .font(.system(.headline, design: .rounded,weight: .bold))
                Picker("Day", selection: $selection){
                    ForEach(days,id: \.self) {
                        Text($0)
                    }
                }.buttonStyle(.bordered)
                    .padding(.top,30)
                HStack{
                    VStack{
                        Text("Start At: ")
                        DatePicker("", selection: $lessonStart,displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    VStack{
                        Text("Finish At:")
                        DatePicker("", selection: $lessonEnd,displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    
                }.padding(.top,20)
                
                
                Button("Add Lesson" ) {
                    
                    if lessonN.isEmpty{
                        showAlert = true
                    }else{
                        presentationMode.wrappedValue.dismiss()
                        addItem()
                    }
                } .foregroundColor(.black)
                    .padding()
                    .background(
                        Color(hue: 0.604, saturation: 0.667, brightness: 0.809)
                    )
                    .cornerRadius(25)
                    .padding(.top, 30)
                    .buttonStyle(.automatic)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Error"),
                            message: Text("Lesson Name can not empty !"),
                            dismissButton: .default(Text("OK"))
                        )
                    }
            } .edgesIgnoringSafeArea(.bottom)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading:
                    Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.backward")
                            .fontWeight(.bold)
                        Text("Back to Syllabus")
                            .fontWeight(.bold)
                    }
                })
                
                


            
            
            
        }.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    private func addItem() {
        withAnimation {
            let newItem = Item(lessonName: lessonN, lessonTime: "\(lessonSTime) - \(lessonETime)" , day: selection)
            modelContext.insert(newItem)
        }
    }
}

#Preview {
    DersEkle()
}
