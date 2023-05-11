//
//  RKMonth.swift
//  RKCalendar
//
//  Created by Raffi Kian on 7/14/19.
//  Copyright © 2019 Raffi Kian. All rights reserved.
//

import SwiftUI

struct RKMonth: View {
    @EnvironmentObject var timeManager: TimeManager
    
    @Binding var isPresented: Bool
    
    @ObservedObject var rkManager: RKManager
    
    let monthOffset: Int
    
    let calendarUnitYMD = Set<Calendar.Component>([.year, .month, .day])
    let daysPerWeek = 7
    var monthsArray: [[Date]] {
        monthArray()
    }
    
    let isPhoneFlag: Bool = UIDevice.current.userInterfaceIdiom == .phone
    let cellWidthPhone = CGFloat(min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) / 7 - 22/7)
    @State private var cellWidthPad   = CGFloat(UIScreen.main.bounds.width / 7 - 22/7)
    
    // 画面の向きを制御
    @State var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State var portraitOrNotFlag: Bool = true

    
//    @State var showTime = false
    
    //isDisabled: !self.isEnabled(date: column),

    var body: some View {
        VStack(alignment: HorizontalAlignment.center, spacing: 10) {
            Text(getMonthHeader()).foregroundColor(self.rkManager.colors.monthHeaderColor)
            VStack(alignment: .leading, spacing: 3) {
                ForEach(monthsArray, id:  \.self) { row in
                    HStack(spacing: 2) {
                        ForEach(row, id:  \.self) { column in
                            HStack(spacing: 0) {
                                if self.isThisMonth(date: column) {
                                    RKCell(rkDate: RKDate(
                                        date: column,
                                        rkManager: self.rkManager,
                                        isDisabled: !self.isEnabled(date: column),
                                        isToday: self.isToday(date: column),
                                        isSelected: self.isSpecialDate(date: column),
                                        isBetweenStartAndEnd: self.isBetweenStartAndEnd(date: column)),
                                           cellWidth: isPhoneFlag ? self.cellWidthPhone : self.cellWidthPad,
                                           runtime: returnRuntimeFromDate(date: column))
                                    .onTapGesture {
                                        self.dateTapped(date: column)
                                    }
                                    .background {
                                        Color(UIColor.systemBackground)
                                            .onTapGesture {
                                                self.dateTapped(date: column)
                                            }
                                    }
                                } else {
                                    VStack {
                                        Text("").frame(width: isPhoneFlag ? self.cellWidthPhone : self.cellWidthPad, height: isPhoneFlag ? self.cellWidthPhone*1.5 : self.cellWidthPad)
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
        }
        // 画面の向きが変わったことを検知
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            orientation = UIDevice.current.orientation
        }
        // 画面の向きが変わった時の処理　.onReceive内で実行したら不具合があったため切り離した
        .onChange(of: orientation) { _ in
            portraitOrNotFlag = self.timeManager.returnOrientation()
            cellWidthPad = CGFloat(UIScreen.main.bounds.width / 7 - 22/7)
        }
        .background(rkManager.colors.monthBackColor)
    }
    
    func returnRuntimeFromDate(date: Date) -> Double {
        var runtime: Double = -1.0
        for num in 0..<self.timeManager.tasks.count {
            let tasks = self.timeManager.tasks[num]
            if isSameDay(date1: date, date2: tasks.taskDate) {
                runtime = tasks.runtime
            }
        }
        return runtime
    }
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }

     func isThisMonth(date: Date) -> Bool {
         return self.rkManager.calendar.isDate(date, equalTo: firstOfMonthForOffset(), toGranularity: .month)
     }
    
    func dateTapped(date: Date) {
        let impactLight = UIImpactFeedbackGenerator(style: .light)
        impactLight.impactOccurred()
        
        //if self.isEnabled(date: date) {
            switch self.rkManager.mode {
            case 0:
                if self.rkManager.selectedDate != nil &&
                    self.rkManager.calendar.isDate(self.rkManager.selectedDate, inSameDayAs: date) {
                    self.rkManager.selectedDate = Date()
                    withAnimation {
                        self.timeManager.currentDate = Date()
                        // 縦画面モードの場合のみ、ダッシュボードの詳細を表示非表示を可能にする
                        if self.timeManager.returnOrientation() {
                            self.timeManager.showDetailWeeklyDashboard.toggle()
                        }
                    }
                } else {
                    self.rkManager.selectedDate = date
                    withAnimation {
                        self.timeManager.currentDate = date
                        self.timeManager.showDetailWeeklyDashboard = true
                    }
                }
                
                self.isPresented = false
            case 1:
                self.rkManager.startDate = date
                self.rkManager.endDate = nil
                self.rkManager.mode = 2
            case 2:
                self.rkManager.endDate = date
                if self.isStartDateAfterEndDate() {
                    self.rkManager.endDate = nil
                    self.rkManager.startDate = nil
                }
                self.rkManager.mode = 1
                self.isPresented = false
            case 3:
                if self.rkManager.selectedDatesContains(date: date) {
                    if let ndx = self.rkManager.selectedDatesFindIndex(date: date) {
                        rkManager.selectedDates.remove(at: ndx)
                    }
                } else {
                    self.rkManager.selectedDates.append(date)
                }
            default:
                self.rkManager.selectedDate = date
                self.isPresented = false
            }
        //}
    }
     
    func monthArray() -> [[Date]] {
        var rowArray = [[Date]]()
        for row in 0 ..< (numberOfDays(offset: monthOffset) / 7) {
            var columnArray = [Date]()
            for column in 0 ... 6 {
                let abc = self.getDateAtIndex(index: (row * 7) + column)
                columnArray.append(abc)
            }
            rowArray.append(columnArray)
        }
        return rowArray
    }
    
    func getMonthHeader() -> String {
        let headerDateFormatter = DateFormatter()
        headerDateFormatter.calendar = rkManager.calendar
        //headerDateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy MM月", options: 0, locale: rkManager.calendar.locale)
        
        headerDateFormatter.dateFormat = "yyyy年 MM月"
        return headerDateFormatter.string(from: firstOfMonthForOffset()).uppercased()
    }
    
    func getDateAtIndex(index: Int) -> Date {
        let firstOfMonth = firstOfMonthForOffset()
        let weekday = rkManager.calendar.component(.weekday, from: firstOfMonth)
        var startOffset = weekday - rkManager.calendar.firstWeekday
        startOffset += startOffset >= 0 ? 0 : daysPerWeek
        var dateComponents = DateComponents()
        dateComponents.day = index - startOffset
        
        return rkManager.calendar.date(byAdding: dateComponents, to: firstOfMonth)!
    }
    
    func numberOfDays(offset : Int) -> Int {
        let firstOfMonth = firstOfMonthForOffset()
        let rangeOfWeeks = rkManager.calendar.range(of: .weekOfMonth, in: .month, for: firstOfMonth)
        
        return (rangeOfWeeks?.count)! * daysPerWeek
    }
    
    func firstOfMonthForOffset() -> Date {
        var offset = DateComponents()
        offset.month = monthOffset
        
        return rkManager.calendar.date(byAdding: offset, to: RKFirstDateMonth())!
    }
    
    func RKFormatDate(date: Date) -> Date {
        let components = rkManager.calendar.dateComponents(calendarUnitYMD, from: date)
        
        return rkManager.calendar.date(from: components)!
    }
    
    func RKFormatAndCompareDate(date: Date, referenceDate: Date) -> Bool {
        let refDate = RKFormatDate(date: referenceDate)
        let clampedDate = RKFormatDate(date: date)
        return refDate == clampedDate
    }
    
    func RKFirstDateMonth() -> Date {
        var components = rkManager.calendar.dateComponents(calendarUnitYMD, from: rkManager.minimumDate)
        components.day = 1
        
        return rkManager.calendar.date(from: components)!
    }
    
    // MARK: - Date Property Checkers
    
    func isToday(date: Date) -> Bool {
        return RKFormatAndCompareDate(date: date, referenceDate: Date())
    }
     
    func isSpecialDate(date: Date) -> Bool {
        return isSelectedDate(date: date) ||
            isStartDate(date: date) ||
            isEndDate(date: date) ||
            isOneOfSelectedDates(date: date)
    }
    
    func isOneOfSelectedDates(date: Date) -> Bool {
        return self.rkManager.selectedDatesContains(date: date)
    }

    func isSelectedDate(date: Date) -> Bool {
        if rkManager.selectedDate == nil {
            return false
        }
        return RKFormatAndCompareDate(date: date, referenceDate: rkManager.selectedDate)
    }
    
    func isStartDate(date: Date) -> Bool {
        if rkManager.startDate == nil {
            return false
        }
        return RKFormatAndCompareDate(date: date, referenceDate: rkManager.startDate)
    }
    
    func isEndDate(date: Date) -> Bool {
        if rkManager.endDate == nil {
            return false
        }
        return RKFormatAndCompareDate(date: date, referenceDate: rkManager.endDate)
    }
    
    func isBetweenStartAndEnd(date: Date) -> Bool {
        if rkManager.startDate == nil {
            return false
        } else if rkManager.endDate == nil {
            return false
        } else if rkManager.calendar.compare(date, to: rkManager.startDate, toGranularity: .day) == .orderedAscending {
            return false
        } else if rkManager.calendar.compare(date, to: rkManager.endDate, toGranularity: .day) == .orderedDescending {
            return false
        }
        return true
    }
    
    func isOneOfDisabledDates(date: Date) -> Bool {
        return self.rkManager.disabledDatesContains(date: date)
    }
    
    func isEnabled(date: Date) -> Bool {
        let clampedDate = RKFormatDate(date: date)
        if rkManager.calendar.compare(clampedDate, to: rkManager.minimumDate, toGranularity: .day) == .orderedAscending || rkManager.calendar.compare(clampedDate, to: rkManager.maximumDate, toGranularity: .day) == .orderedDescending {
            return false
        }
        return !isOneOfDisabledDates(date: date)
    }
    
    func isStartDateAfterEndDate() -> Bool {
        if rkManager.startDate == nil {
            return false
        } else if rkManager.endDate == nil {
            return false
        } else if rkManager.calendar.compare(rkManager.endDate, to: rkManager.startDate, toGranularity: .day) == .orderedDescending {
            return false
        }
        return true
    }
}

#if DEBUG
//struct RKMonth_Previews : PreviewProvider {
//    static var previews: some View {
//        RKMonth(isPresented: .constant(false),rkManager: RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 0), monthOffset: 0)
//    }
//}
#endif

