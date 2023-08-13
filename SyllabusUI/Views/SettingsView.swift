//
//  SettingsView.swift
//  SyllabusUI
//
//  Created by Şadan Efe Öz on 9.08.2023.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @State private var selectionTime = 15
    @State private var selectionColor = "Blue"
    @Bindable var setTime = SettingsClass()
    @State private var timeArray = [0,10,15,30,40,45,60]
    @State private var colorArray = ["Blue","Purple","Orange","Black","Pink","Red","Yellow"]
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .blur(radius: 250)
                .foregroundColor(Color(hue: 0.704, saturation: 0.627, brightness: 0.798))
                .offset(x: -270)
            RoundedRectangle(cornerRadius: 25)
                .blur(radius: 250)
                .foregroundColor(Color(hue: 0.667, saturation: 0.764, brightness: 0.769, opacity: 0.602))
                .offset(x: 300)
            VStack(alignment: .leading){
                Text("Settings")
                    .font(.system(size: 30,weight: .bold))
                    .padding(.horizontal, 30)
                    .padding(.top,40)
                List{
                    Section(""){
                        HStack{
                            Text("Notification Time :")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 18,weight: .bold))
                            Spacer()
                            Picker("", selection: $selectionTime) {
                                ForEach(timeArray, id: \.self) { time in
                                    Text("\(time)")
                                }
                            }.buttonStyle(.borderedProminent)
                                .tint(.accentColor)
                                .onChange(of: selectionTime) {
                                    setTime.time = selectionTime
                                    print(setTime.time)
                                }
                        }
                        HStack{
                            Text("Color")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 18,weight: .bold))
                            Spacer()
                            Picker("", selection: $selectionColor) {
                                ForEach(colorArray,id: \.self) {
                                    Text($0)
                                }
                            }.buttonStyle(.borderedProminent)
                                .tint(.accentColor)
                        }
                    }
                    .labelsHidden()
                    .padding(20)
                }   .scrollDisabled(true)
                    .padding(.top,5)
                    .scrollContentBackground(.hidden)
                    .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.971, opacity: 0))
                
            }
        }
    }
}

#Preview {
    SettingsView()
}
