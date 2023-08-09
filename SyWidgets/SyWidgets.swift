//
//  SyWidgets.swift
//  SyWidgets
//
//  Created by Şadan Efe Öz on 6.08.2023.
//

import WidgetKit
import SwiftUI
import SwiftData

struct Provider: TimelineProvider {
    @MainActor func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), examsArr: getExams())
    }

    @MainActor func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), examsArr: getExams())
        completion(entry)
    }

    @MainActor func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let timeline = Timeline(entries: [SimpleEntry(date: .now, examsArr: getExams())], policy: .after(.now.advanced(by: 60*5)))
        completion(timeline)
    }
}

@MainActor
private func getExams() -> [Exam]{
    guard let modelContainer = try? ModelContainer(for: [Exam.self]) else{
        return []
    }
    let descriptor = FetchDescriptor<Exam>()
    let examsArr = try? modelContainer.mainContext.fetch(descriptor)
    return examsArr ?? []
}
struct SimpleEntry: TimelineEntry {
    let date: Date
    let examsArr : [Exam]
}

struct SyWidgetsEntryView : View {
    var entry: Provider.Entry
    let functions = Funcs()
    var sortedExams: [Exam] {
        return entry.examsArr.sorted { $0.examDate < $1.examDate }
    }
    
    var body: some View {
            VStack{
                ForEach(sortedExams.prefix(1)){ exam in
                    VStack{
                        Text(exam.examName)
                            .padding(.bottom ,10)
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                        Text(functions.formattedDate(date: exam.examDate))
                            .fontWeight(.semibold)
                    }
                }
            }
        
           
    }
}

struct SyWidgets: Widget {
    let kind: String = "SyWidgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                SyWidgetsEntryView(entry: entry)
                    .containerBackground(.teal.gradient, for: .widget)
            } else {
                SyWidgetsEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Syllabus UI")
        .description("Check your Lessons")
    }
}

#Preview(as: .systemSmall) {
    SyWidgets()
} timeline: {
    SimpleEntry(date: .now, examsArr: [])
    SimpleEntry(date: .now,examsArr: [])
}
