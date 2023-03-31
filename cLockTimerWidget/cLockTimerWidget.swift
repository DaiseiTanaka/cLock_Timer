//
//  cLockTimerWidget.swift
//  cLockTimerWidget
//
//  Created by 田中大誓 on 2023/03/31.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), characterName: "", characterImageName: "")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), characterName: "", characterImageName: "")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        var characterName = ""
        var characterImageName = ""
        let userDefaults = UserDefaults(suiteName: "group.myproject.cLockTimer.myWidget")
        if let userDefaults = userDefaults {
            characterName = userDefaults.string(forKey: "selectedCharacter") ?? ""
            characterImageName = userDefaults.string(forKey: "selectedCharacterImageName") ?? ""
        }
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, characterName: characterName, characterImageName: characterImageName)
            entries.append(entry)
        }
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let characterName: String
    let characterImageName: String
}

struct cLockTimerWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
//            Text(entry.characterName)
//                .padding(.top)
            Image(entry.characterImageName)
                .resizable()
                .scaledToFit()
                .padding()
                .shadow(radius: 4)
        }
    }
}

struct cLockTimerWidget: Widget {
    let kind: String = "cLockTimerWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            cLockTimerWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct cLockTimerWidget_Previews: PreviewProvider {
    static var previews: some View {
        cLockTimerWidgetEntryView(entry: SimpleEntry(date: Date(),  characterName: "", characterImageName: ""))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
