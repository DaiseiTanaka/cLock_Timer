//
//  UserDataView.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/03/15.
//

import SwiftUI

struct UserDataView: View {
    @EnvironmentObject var timeManager: TimeManager
    
    @Binding var currentDate: Date
    
    // Month update on arrow button clickes
    @State var currentMonth: Int = 0
    
    // Days
    //let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    private let days: [String] = ["日", "月", "火", "水", "木", "金", "土"]
    
    // calendar columns
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
                
        VStack(spacing: 15) {
            
            // 週間達成目標、達成度を表示
            weeklyDashboard
            
            // 選択した日の詳細を表示
            achievementView
            
            // 年、月、月変更ボタン
            calendarHeaderView
            
            // 曜日表示
            dayView

            // カレンダー表示
            calendarView
            
        }
        .padding(.horizontal, 3)
        .onChange(of: currentMonth) { newValue in
            // updating Month
            currentDate = getCurrentMonth()
        }
        .onAppear {
            print("\n✨ UserDataView Appear")
            // 今週のデータを更新
            self.timeManager.loadWeeklyDashboardData()
        }
        .onDisappear {
            print("\n🌕 UserDataView Disappear")
        }
    }
    
    // Calendar View
    var calendarView: some View {
        LazyVGrid(columns: columns, spacing: 3) {
            ForEach(extractDate()) { value in
                CardView(value: value)
                    .onTapGesture {
                        currentDate = value.date
                    }
            }
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        VStack {
            if value.day != -1 {
                if let task = self.timeManager.tasks.first(where: { task in
                    return isSameDay(date1: task.taskDate, date2: value.date)
                }) {
                    // タスクを実行した日
                    Text("\(value.day)")
                        .font(.footnote.bold())
                        .foregroundColor(returnDateBackgroundColor(date: value.date))
                        .frame(maxWidth: .infinity)
                        .background (
                            ZStack {
                                // 選択中の日付にマーク
                                isSameDay(date1: value.date, date2: currentDate) ?
                                Color(UIColor.yellow) : Color(UIColor.systemBackground)
                                
                            }
                        )
                    
                    Spacer()
                    
                    ZStack {
                        VStack {
                            Spacer(minLength: 0)
                            
                            if task.runtime < self.timeManager.taskTime {
                                returnRectanglerColor(runtime: task.runtime)
                                    .cornerRadius(5)
                                    .frame(maxHeight: 20 + 15 * task.runtime / self.timeManager.taskTime)
                                
                            } else if task.runtime <= self.timeManager.taskTime * 1.5 {
                                returnRectanglerColor(runtime: task.runtime)
                                    .cornerRadius(5)
                                    .frame(maxHeight: 35 + 15 * (task.runtime - self.timeManager.taskTime) / (self.timeManager.taskTime * 0.5))
                                
                            } else {
                                returnRectanglerColor(runtime: task.runtime)
                                    .cornerRadius(5)
                                    .frame(maxHeight: 50)
                            }
                        }
                        
                        VStack {
                            Spacer()
                            Text("\(self.timeManager.runtimeToString(time: task.runtime, second: false))")
                                .foregroundColor(.white)
                                .font(.footnote.bold())
                                .padding(.bottom, 2)
                        }
                    }
                }
                else {
                    // タスクを実行していない日
                    Text("\(value.day)")
                        .font(.footnote.bold())
                        .foregroundColor(returnDateBackgroundColor(date: value.date))
                        .frame(maxWidth: .infinity)
                        .background (
                            isSameDay(date1: value.date, date2: currentDate) ?
                            Color(UIColor.yellow) : Color(UIColor.systemBackground)
                        )
                    
                    Color(UIColor.systemBackground)
                }
                
                // 枠線
                Rectangle()
                    .frame(height: 0.75)
                    .foregroundColor(Color(UIColor.systemGray6))
            }
        }
        .frame(height: 80)
    }
    
    // weekly dashboard
    var weeklyDashboard: some View {
        VStack(spacing: 15) {
            HStack(spacing: 0) {
                VStack {
                    Text("● 今週の実績")
                        .font(.caption)
                    ZStack {
                        Text("\(self.timeManager.runtimeToString(time: self.timeManager.runtime, second: false))")
                            .font(.title2.bold())
                        ForEach(0 ..< 7, id: \.self) { num in
                            Circle()
                                .trim(from: Double(num) / 7 + 0.01, to: (Double(num) + 1) / 7 - 0.01)
                                .stroke(Color.blue, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                                .scaledToFit()
                                .rotationEffect(Angle(degrees: -90))
                                .padding(10)
                                .opacity(self.timeManager.todayNum >= num ? 0.4 : 0.1)
                        }
                        Circle()
                            .trim(from: 0.01, to: self.timeManager.thisWeekRuntimeSum / (self.timeManager.taskTime * 7) - 0.01)
                            .stroke(Color.blue, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                            .scaledToFit()
                            .rotationEffect(Angle(degrees: -90))
                            .opacity(0.5)
                        Circle()
                            .stroke(Color.blue, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                            .scaledToFit()
                            .opacity(0.1)
                    }
                }
                
                VStack(spacing: 3) {
                    Text("● 今週の目標: \(self.timeManager.runtimeToString(time: self.timeManager.taskTime * 7, second: false))")
                        .font(.caption)
                    
                    Spacer(minLength: 0)
                    
                    ForEach(0 ..< 7, id: \.self) { num in
                        HStack {
                            ZStack {
                                Circle()
                                    .opacity(num == self.timeManager.todayNum ? 0.7 : 0)
                                    .foregroundColor(num == self.timeManager.todayNum ? Color(UIColor.yellow) : Color.black)
                                Text(days[num])
                                    .font(.caption2)
                                    .foregroundColor(num == self.timeManager.todayNum ? Color.black : Color.primary)
                                
                            }
                            SquareProgressView(value: self.timeManager.thisWeekRuntimeList[num] / self.timeManager.taskTime)
                                .frame(height: 6.5)
                            Text("\(self.timeManager.runtimeToString(time: self.timeManager.thisWeekRuntimeList[num], second: false))")
                                .font(.caption2)
                        }
                    }
                    
                    Spacer(minLength: 0)
                }
                .frame(maxWidth: .infinity)
                .padding(.leading, 20)
                
                
                Spacer()
            }
            .frame(height: 170)
            .padding(.horizontal, 10)
            
            Spacer(minLength: 0)
            
            HStack {
                Spacer(minLength: 0)
                VStack {
                    HStack {
                        Image(systemName: "clock")
                            .font(.caption)
                        Text("総タスク実行時間")
                            .font(.caption)
                        Spacer(minLength: 0)
                    }
                    Spacer(minLength: 0)
                    
                    Text("\(self.timeManager.runtimeToString(time: self.timeManager.runtimeEverSum, second: false))")
                        .font(.headline)
                    Text("今月: \(self.timeManager.runtimeToString(time: self.timeManager.thisMonthRuntimeSum, second: false))")
                        .font(.caption)
                    
                    //Spacer(minLength: 0)
                }
                .padding(7)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(5)
                .frame(width: 160, height: 70)
                
                Spacer(minLength: 0)
                
                VStack {
                    HStack {
                        Image(systemName: "calendar")
                        Text("連続タスク実行日数")
                            .font(.caption)
                        Spacer(minLength: 0)
                    }
                    Spacer(minLength: 0)
                    Text("\(self.timeManager.recentConsecutiveDays)日")
                        .font(.headline)
                    Text("自己ベスト: \(self.timeManager.maxConsecutiveDays)日")
                        .font(.caption)
                }
                .padding(7)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(5)
                .frame(width: 160, height: 70)
                
                Spacer(minLength: 0)
            }
            //.background(Color(UIColor.systemGray4))
        }
        .padding(.top, 10)
    }
    
    // Calendar Header
    var calendarHeaderView: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                Text(extraDate()[0])
                    .font(.caption)
                    .fontWeight(.semibold)
                
                Text(extraDate()[1])
                    .font(.title.bold())
            }
            
            Spacer(minLength: 0)
            
            Button {
                withAnimation {
                    currentMonth -= 1
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title2)
            }
            
            Button {
                withAnimation {
                    currentDate = Date()
                    currentMonth = 0
                }
            } label: {
                Image(systemName: "calendar.badge.clock")
                    .font(.title2)
            }
            
            Button {
                withAnimation {
                    currentMonth += 1
                }
            } label: {
                Image(systemName: "chevron.right")
                    .font(.title2)
            }
        }
        .padding(.horizontal)
    }
    
    // 曜日表示
    var dayView: some View {
        HStack(spacing: 0) {
            ForEach(days, id: \.self) { day in
                Text(day)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    // Achievement View
    var achievementView: some View {
        VStack(spacing: 0) {
            
            if let tasks = self.timeManager.tasks.first(where: { tasks in
                return isSameDay(date1: tasks.taskDate, date2: currentDate)
            }) {
                ForEach(tasks.task, id: \.title) { task in
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text(task.title)
                                .font(.title3.bold())
                            
                            VStack {
                                Spacer()
                                Text(String(format: "%02d:%02d~", self.timeManager.startHourSelection, self.timeManager.startMinSelection))
                                    .font(.subheadline)
                                    .padding(.bottom, 3)
                            }
                            Spacer(minLength: 0)
                            Text("\(self.timeManager.runtimeToString(time: tasks.runtime, second: false))")
                                .font(.body.bold())
                            Text("/ \( self.timeManager.runtimeToString(time: self.timeManager.taskTime, second: false))")
                                .font(.subheadline.bold())
                        }
                        
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        returnRectanglerColor(runtime: tasks.runtime)
                            .opacity(0.5)
                            .cornerRadius(10)
                    )
                }
            }
        }
        .padding()
    }
    
    // MARK: - 画面制御関連
    // タスク実行バーの色を返す
    private func returnRectanglerColor(runtime: Double) -> Color {
        if runtime < self.timeManager.taskTime {
            return Color.red
            
        } else if runtime <= self.timeManager.taskTime * 1.5 {
            return Color.green
            
        } else {
            return Color.blue
            
        }
    }
    
    // カレンダーの日付の背景色を返す
    private func returnDateBackgroundColor(date: Date) -> Color {
        // 当日は赤
        if isSameDay(date1: date, date2: Date()) {
            return Color.red
        // 選択中の日付は黒
        } else if isSameDay(date1: date, date2: currentDate) {
            return Color.black
        // 普段は一般テキストの色
        } else {
            return Color.primary
        }
    }
    
    // checking dates
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    // extrating Year And Month for display
    func extraDate() -> [String] {
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        // Getting Current Month Date
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        
        return currentMonth
    }
    
    func extractDate() -> [DateValue] {
        
        let calendar = Calendar.current
        
        // Getting Current Month Date
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        // adding offset days to get exact week day
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }

}

struct UserDataView_Previews: PreviewProvider {
    static var previews: some View {
        
        TestContentView()
            .environmentObject(TimeManager())
        
    }
}

extension Date {
    
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        
        // getting start Date
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
                
        // getting date
        return range.compactMap { day -> Date in
            
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}
