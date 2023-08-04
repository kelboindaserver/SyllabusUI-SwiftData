//
//  ContentView.swift
//  SyllabusUI
//
//  Created by Sadan Efe Oz on 30.07.2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var body: some View {
        NavigationView {
            ZStack{
                
                RoundedRectangle(cornerRadius: 25)
                    .blur(radius: 250)
                    .foregroundColor(Color(hue: 0.725, saturation: 1.0, brightness: 1.0))
                    .offset(x: -270)
                RoundedRectangle(cornerRadius: 25)
                    .blur(radius: 250)
                    .foregroundColor(Color(hue: 0.604, saturation: 1.0, brightness: 1.0, opacity: 0.602))
                    .offset(x: 300)
                
                VStack(alignment: .leading){
                    Text("Syllabus")
                        .font(.system(size: 30,weight: .bold))
                        .padding(.horizontal, 30)
                    List {
                        Section(header: Text("MONDAY")
                            .fontWeight(.bold)
                            .font(.system(size: 22))) {
                                ForEach(items) { item in
                                    if item.day == "Monday"{
                                        HStack{
                                            Text(item.lessonName)
                                                .padding()
                                                .fontWeight(.bold)
                                                .font(.system(size: 20))
                                            Spacer()
                                            Text("\(item.lessonTime)")
                                                .padding()
                                                .fontWeight(.light)
                                                .font(.system(size: 15))
                                        }
                                        
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
                                            Text(item.lessonName)
                                                .padding()
                                                .fontWeight(.bold)
                                                .font(.system(size: 20))
                                            Spacer()
                                            Text("\(item.lessonTime)")
                                                .padding()
                                                .fontWeight(.light)
                                                .font(.system(size: 15))
                                        }
                                        
                                        
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
                                            Text(item.lessonName)
                                                .padding()
                                                .fontWeight(.bold)
                                                .font(.system(size: 20))
                                            Spacer()
                                            Text("\(item.lessonTime)")
                                                .padding()
                                                .fontWeight(.light)
                                                .font(.system(size: 15))
                                        }
                                        
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
                                            Text(item.lessonName)
                                                .padding()
                                                .fontWeight(.bold)
                                                .font(.system(size: 20))
                                            Spacer()
                                            Text("\(item.lessonTime)")
                                                .padding()
                                                .fontWeight(.light)
                                                .font(.system(size: 15))
                                        }
                                        
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
                                            Text(item.lessonName)
                                                .padding()
                                                .fontWeight(.bold)
                                                .font(.system(size: 20))
                                            Spacer()
                                            Text("\(item.lessonTime)")
                                                .padding()
                                                .fontWeight(.light)
                                                .font(.system(size: 15))
                                        }
                                        
                                    }
                                    
                                }
                                .onDelete(perform: deleteItems)
                            }
                        
                    }.scrollContentBackground(.hidden)
                    
                    
                    
                    
                    
                }
                
            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    NavigationLink(destination: DersEkle()) {
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
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
