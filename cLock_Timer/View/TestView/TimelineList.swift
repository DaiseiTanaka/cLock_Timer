//
//  TimelineList.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/03/22.
//

import SwiftUI

struct TimelineList: View {
    @EnvironmentObject var timeManager: TimeManager
    
    // change these to visually style the timeline
    private static let lineWidth: CGFloat = 2
    private static let dotDiameter: CGFloat = 8
    
    let items: [Appointment]
    
    let dotColor: Color
    
    private let dateFormatter: DateFormatter
    
    init(items: [Appointment], dotColor: Color) {
        self.items = items
        self.dotColor = dotColor
        dateFormatter = DateFormatter()
        // the format of the dates on the timeline
        //dateFormatter.dateFormat = "EEE\ndd\nhh:mm"
        dateFormatter.timeZone = .current
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        dateFormatter.locale = NSLocale.system

        dateFormatter.dateFormat = "hh:mm"
    }
    
    
    var body: some View {
        List(Array(items.enumerated()), id: \.offset) { index, item in
            rowAt(index, item: items[index])
            // removes spacing between the rows
                .listRowInsets(EdgeInsets())
            // hides separators on SwiftUI 3, for other versions
            // check out https://swiftuirecipes.com/blog/remove-list-separator-in-swiftui
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
        }
        .onAppear {
            print("TimelineList Appear!")
        }
    }
    
    @ViewBuilder private func rowAt(_ index: Int, item: Appointment) -> some View {
        let calendar = Calendar.current
        // アクションを起こした日時
        let date = item.date
        //　前のデータがある
        let hasPrevious: Bool = index > 0
        // 次のデータがある
        let hasNext:     Bool = index < items.count - 1
        //　前のデータがあって、前のデータと同じ日時である
        let isPreviousSameDate = hasPrevious && !calendar.isDate(date, inSameDayAs: items[index - 1].date)
        
        HStack {
            ZStack {
                Color.clear // effectively centers the text
                if !isPreviousSameDate {
                    Text(dateFormatter.string(from: date))
                        .font(.system(size: 14))
                        .multilineTextAlignment(.center)
                }
            }
            .frame(width: 40)
            
            GeometryReader { geo in
                ZStack {
                    Color.clear
                    line(height: geo.size.height,
                         hasPrevious: hasPrevious,
                         hasNext: hasNext,
                         isPreviousSameDate: isPreviousSameDate)
                }
            }
            .frame(width: 10)
            
            Text(item.message)
        }
    }
    
    // this methods implements the rules for showing dots in the
    // timeline, which might differ based on requirements
    @ViewBuilder private func line(height: CGFloat,
                                   hasPrevious: Bool,
                                   hasNext: Bool,
                                   isPreviousSameDate: Bool) -> some View {
        let lineView = Rectangle()
            .foregroundColor(.black)
            .frame(width: TimelineList.lineWidth)
        
        let dot = Circle()
            .fill(dotColor)
            .frame(width: TimelineList.dotDiameter,
                   height: TimelineList.dotDiameter)
        
        let halfHeight = height / 2
        let quarterHeight = halfHeight / 2
        
        if isPreviousSameDate && hasNext {
            lineView
            
        } else if hasPrevious && hasNext {
            lineView
            dot
            
        } else if hasNext {
            lineView
                .frame(height: halfHeight)
                .offset(y: quarterHeight)
            dot
            
        } else if hasPrevious {
            lineView
                .frame(height: halfHeight)
                .offset(y: -quarterHeight)
            dot
            
        } else {
            dot
            
        }
    }
}

struct Appointment {
    let date: Date
    let message: String
}
