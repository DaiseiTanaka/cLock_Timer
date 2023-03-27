//
//  TestUserDataView.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/03/21.
//

import SwiftUI

struct TestUserDataView: View {
    @EnvironmentObject var timeManager: TimeManager
    
    @Binding var currentDate: Date
    
    // Month update on arrow button clickes
    @State var currentMonth: Int = 0
    
    // Days
    //let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let days: [String] = ["日", "月", "火", "水", "木", "金", "土"]
    
    let tasks: [TaskMetaData] = [
        TaskMetaData(
            task: [Task(title: "Study SwiftUI")],
            duration: 10,
            runtime: 3900,
            taskDate: getSampleDate(offset: 0),
            usedTimeData: [UsedTimeData(title: "running_timer")]
        ),
        TaskMetaData(
            task: [Task(title: "Talk to Jason")],
            duration: 10,
            runtime: 7200,
            taskDate: getSampleDate(offset: -1),
            usedTimeData: [UsedTimeData(title: "running_timer")]
        ),
        TaskMetaData(
            task: [Task(title: "Talk to Jason")],
            duration: 10,
            runtime: 3900,
            taskDate: getSampleDate(offset: -2),
            usedTimeData: [UsedTimeData(title: "running_timer")]
        ),
        TaskMetaData(
            task: [Task(title: "Talk to Jason")],
            duration: 10,
            runtime: 3800,
            taskDate: getSampleDate(offset: -3),
            usedTimeData: [UsedTimeData(title: "running_timer")]
        ),
        TaskMetaData(
            task: [Task(title: "Talk to Jason")],
            duration: 10,
            runtime: 8590,
            taskDate: getSampleDate(offset: -4),
            usedTimeData: [UsedTimeData(title: "running_timer")]
        ),
        TaskMetaData(
            task: [Task(title: "Talk to Jason")],
            duration: 10,
            runtime: 3600,
            taskDate: getSampleDate(offset: -5),
            usedTimeData: [UsedTimeData(title: "running_timer")]
        ),
        TaskMetaData(
            task: [Task(title: "Talk to Jason")],
            duration: 10,
            runtime: 3100,
            taskDate: getSampleDate(offset: -6),
            usedTimeData: [UsedTimeData(title: "running_timer")]
        ),
        TaskMetaData(
            task: [Task(title: "Talk to Jason")],
            duration: 10,
            runtime: 4500,
            taskDate: getSampleDate(offset: -7),
            usedTimeData: [UsedTimeData(title: "running_timer")]
        ),
        TaskMetaData(
            task: [Task(title: "Talk to Jason")],
            duration: 10,
            runtime: 4000,
            taskDate: getSampleDate(offset: -8),
            usedTimeData: [UsedTimeData(title: "running_timer")]
        ),
        TaskMetaData(
            task: [Task(title: "Talk to Jason")],
            duration: 10,
            runtime: 3600,
            taskDate: getSampleDate(offset: -9),
            usedTimeData: [UsedTimeData(title: "running_timer")]
        ),
        TaskMetaData(
            task: [Task(title: "Talk to Jason")],
            duration: 10,
            runtime: 9250,
            taskDate: getSampleDate(offset: -10),
            usedTimeData: [UsedTimeData(title: "running_timer")]
        ),
        TaskMetaData(
            task: [Task(title: "Talk to Jason")],
            duration: 10,
            runtime: 3500,
            taskDate: getSampleDate(offset: -11),
            usedTimeData: [UsedTimeData(title: "running_timer")]
        ),
        TaskMetaData(
            task: [Task(title: "Talk to Jason")],
            duration: 10,
            runtime: 7200,
            taskDate: getSampleDate(offset: -12),
            usedTimeData: [UsedTimeData(title: "running_timer")]
        ),
        TaskMetaData(
            task: [Task(title: "Talk to Jason")],
            duration: 10,
            runtime: 3900,
            taskDate: getSampleDate(offset: -13),
            usedTimeData: [UsedTimeData(title: "running_timer")]
        ),
        TaskMetaData(
            task: [Task(title: "Talk to Jason")],
            duration: 10,
            runtime: 3800,
            taskDate: getSampleDate(offset: -14),
            usedTimeData: [UsedTimeData(title: "running_timer")]
        ),
        TaskMetaData(
            task: [Task(title: "Talk to Jason")],
            duration: 10,
            runtime: 8500,
            taskDate: getSampleDate(offset: -15),
            usedTimeData: [UsedTimeData(title: "running_timer")]
        ),
        TaskMetaData(
            task: [Task(title: "Talk to Jason")],
            duration: 10,
            runtime: 3600,
            taskDate: getSampleDate(offset: -16),
            usedTimeData: [UsedTimeData(title: "running_timer")]
        ),
        TaskMetaData(
            task: [Task(title: "Talk to Jason")],
            duration: 10,
            runtime: 3000,
            taskDate: getSampleDate(offset: -17),
            usedTimeData: [UsedTimeData(title: "running_timer")]
        ),
        TaskMetaData(
            task: [Task(title: "Talk to Jason")],
            duration: 10,
            runtime: 4500,
            taskDate: getSampleDate(offset: -18),
            usedTimeData: [UsedTimeData(title: "running_timer")]
        ),
        TaskMetaData(
            task: [Task(title: "Talk to Jason")],
            duration: 10,
            runtime: 4000,
            taskDate: getSampleDate(offset: -19),
            usedTimeData: [UsedTimeData(title: "running_timer")]
        ),
        TaskMetaData(
            task: [Task(title: "Talk to Jason")],
            duration: 10,
            runtime: 3600,
            taskDate: getSampleDate(offset: -20),
            usedTimeData: [UsedTimeData(title: "running_timer")]
        ),
        TaskMetaData(
            task: [Task(title: "Talk to Jason")],
            duration: 10,
            runtime: 9650,
            taskDate: getSampleDate(offset: -21),
            usedTimeData: [UsedTimeData(title: "running_timer")]
        ),
        TaskMetaData(
            task: [Task(title: "Talk to Jason")],
            duration: 10,
            runtime: 3500,
            taskDate: getSampleDate(offset: -22),
            usedTimeData: [UsedTimeData(title: "running_timer")]
        ),
    ]
    
    var taskTime: Double = 60 * 60
    var runtime: Double = 15
    
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
            testloadWeeklyDashboardData()
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
                if let task = tasks.first(where: { task in
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
                            
                            if task.runtime < taskTime {
                                returnRectanglerColor(runtime: task.runtime)
                                    .cornerRadius(5)
                                    .frame(maxHeight: 20 + 15 * task.runtime / taskTime)
                                
                            } else if task.runtime <= taskTime * 1.5 {
                                returnRectanglerColor(runtime: task.runtime)
                                    .cornerRadius(5)
                                    .frame(maxHeight: 35 + 15 * (task.runtime - taskTime) / (taskTime * 0.5))
                                
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
                        Text("\(self.timeManager.runtimeToString(time: testthisWeekRuntimeSum, second: false))")
                            .font(.title2.bold())
                        ForEach(0 ..< 7, id: \.self) { num in
                            Circle()
                                .trim(from: Double(num) / 7 + 0.01, to: (Double(num) + 1) / 7 - 0.01)
                                .stroke(Color.blue, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                                .scaledToFit()
                                .rotationEffect(Angle(degrees: -90))
                                .padding(10)
                                .opacity(testtodayNum >= num ? 0.4 : 0.1)
                        }
                        Circle()
                            .trim(from: 0.01, to: testthisWeekRuntimeSum / (taskTime * 7) - 0.01)
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
                    Text("● 今週の目標: \(self.timeManager.runtimeToString(time: taskTime * 7, second: false))")
                        .font(.caption)
                    
                    Spacer(minLength: 0)
                    
                    ForEach(0 ..< 7, id: \.self) { num in
                        HStack {
                            ZStack {
                                Circle()
                                    .opacity(num == testtodayNum ? 0.7 : 0)
                                    .foregroundColor(num == testtodayNum ? Color(UIColor.yellow) : Color.black)
                                Text(days[num])
                                    .font(.caption2)
                                    .foregroundColor(num == testtodayNum ? Color.black : Color.primary)
                                
                            }
                            TestSquareProgressView(value: testthisWeekRuntimeList[num] / taskTime)
                                .frame(height: 6.5)
                            Text("\(self.timeManager.runtimeToString(time: testthisWeekRuntimeList[num], second: false))")
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
                    
                    Text("\(self.timeManager.runtimeToString(time: testruntimeEverSum, second: false))")
                        .font(.headline)
                    Text("今月: \(self.timeManager.runtimeToString(time: testthisMonthRuntimeSum, second: false))")
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
                    Text("\(testrecentConsecutiveDays)日")
                        .font(.headline)
                    Text("自己ベスト: \(testmaxConsecutiveDays)日")
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
            
            if let tasks = tasks.first(where: { tasks in
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
                            Text("/ \( self.timeManager.runtimeToString(time: taskTime, second: false))")
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
        if runtime < taskTime {
            return Color.red
            
        } else if runtime <= taskTime * 1.5 {
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
    
    // MARK: - LoadDashBoard
    // MARK: - 今週１週間のデータをまとめる

    @State var testthisWeekRuntimeList: [Double] = [0, 0, 0, 0, 0, 0, 0]
    @State var testtodayNum: Int = 0
    @State var testthisWeekRuntimeSum: Double = 0

    func testloadThisWeekData() {
        testthisWeekRuntimeList = [0, 0, 0, 0, 0, 0, 0]
        testthisWeekRuntimeSum = 0
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ja_JP")
        let today = Date()
        let thisWeekNum = calendar.component(.weekOfYear, from: today)
        testtodayNum = Int(calendar.component(.weekday, from: today)) - 1
        
        if tasks.count != 0 {
            for num in 0..<tasks.count {
                let day = self.tasks[num].taskDate
                let dayRuntime = self.tasks[num].runtime
                let dayWeekNum = calendar.component(.weekOfYear, from: day)
                let daysNum = Int(calendar.component(.weekday, from: day)) // ex) 月曜日: 2
                if thisWeekNum == dayWeekNum {
                    self.testthisWeekRuntimeList[daysNum - 1] = dayRuntime
                    self.testthisWeekRuntimeSum += dayRuntime
                }
                
            }
        }
        print("loadThisWeekData() thisWeekRuntimeList: \(testthisWeekRuntimeList) thisWeekRuntimeSum: \(testthisWeekRuntimeSum)")
    }
    
    
    // MARK: - 今月のデータをまとめる
    
    // 今月の総タスク実行時間
    @State var testthisMonthRuntimeSum: Double = 0

    func testloadThisMonthData() {
        testthisMonthRuntimeSum = 0
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ja_JP")
        let today = Date()
        let thisYearNum  = calendar.component(.year, from: today)
        let thisMonthNum = calendar.component(.month, from: today)
        
        if tasks.count != 0 {
            for num in 0..<tasks.count {
                let day = self.tasks[num].taskDate
                let dayRuntime = self.tasks[num].runtime
                let dayYearNum = calendar.component(.year, from: day)
                let dayMonthNum = calendar.component(.month, from: day)
                if thisYearNum == dayYearNum && thisMonthNum == dayMonthNum {
                    testthisMonthRuntimeSum += dayRuntime
                    //print("\(thisYearNum) \(dayYearNum)  \(thisMonthNum) \(dayMonthNum)")
                }
            }
        }
        
        print("loadThisMonthData() thisMonthRuntimeSum: \(testthisMonthRuntimeSum)")
    }
    
    // MARK: - 今までの全てのデータをまとめる
    
    // 今までの総タスク実行時間
    @State var testruntimeEverSum: Double = 0
    
    // 自己ベスト　連続日数
    @State var testmaxConsecutiveDays: Int = 1
    
    // 直近の連続日数
    @State var testrecentConsecutiveDays: Int = 1
    
    func testloadAllEverData() {
        testruntimeEverSum = 0

        if tasks.count != 0 {
            for num in 0..<tasks.count {
                let dayRuntime = self.tasks[num].runtime
                testruntimeEverSum += dayRuntime
            }
        }
        
        print("loadAllEverData() thisMonthRuntimeSum: \(testruntimeEverSum)")
    }
    
    // weekly dashboard用のデータを全てロードする
    func testloadWeeklyDashboardData() {
        
        testloadThisWeekData()
        testloadThisMonthData()
        testloadAllEverData()
        
        testcountMaxConsecutiveDays()
        testcountRecentConsecutiveDays()
    }
    
    // 今までの最大連続タスク実行日数を数える
    func testcountMaxConsecutiveDays() {
        testmaxConsecutiveDays = 1
        var consecutiveDays = 1
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ja_JP")
        
        if tasks.count >= 2 {
            for num in 0..<tasks.count - 1 {
                let day = self.tasks[num].taskDate
                let nextDay = self.tasks[num + 1].taskDate
                let dayDay = calendar.component(.day, from: day)
                let nextDayDay = calendar.component(.day, from: nextDay)
                //print("\(num) \(dayDay) \(nextDayDay) \(testmaxConsecutiveDays) \(consecutiveDays)")
                if dayDay - nextDayDay == 1 {
                    consecutiveDays += 1
                    if consecutiveDays > testmaxConsecutiveDays {
                        testmaxConsecutiveDays = consecutiveDays
                    }
                } else {
                    if consecutiveDays > testmaxConsecutiveDays {
                        testmaxConsecutiveDays = consecutiveDays
                    }
                    consecutiveDays = 1
                }
            }
        }
        
        print("countMaxConsecutiveDays() maxConsecutiveDays: \(testmaxConsecutiveDays)")
    }
    
    // 現在の連続タスク実行日数を数える
    func testcountRecentConsecutiveDays() {
        testrecentConsecutiveDays = 1
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ja_JP")
        
        if tasks.count >= 2 {
            for num in 0..<tasks.count - 1 {
                let day     = self.tasks[num].taskDate
                let prevDay = self.tasks[num + 1].taskDate
                let dayDay     = calendar.component(.day, from: day)
                let prevDayDay = calendar.component(.day, from: prevDay)
                //print("\(num) \(dayDay) \(prevDayDay) \(testrecentConsecutiveDays)")
                if dayDay - prevDayDay == 1 {
                    testrecentConsecutiveDays += 1
                } else {
                    break
                }
            }
        }
        
        print("countRecentConsecutiveDays() recentConsecutiveDays: \(testrecentConsecutiveDays)")
    }

}

struct TestUserDataView_Previews: PreviewProvider {
    static var previews: some View {
        
        TestContentView()
            .environmentObject(TimeManager())
        
    }
}

struct TestSquareProgressView: View {
    var value: CGFloat
    var baseColor: Color = Color.blue.opacity(0.1)
    
    @State var cd = Date()

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .trailing) {
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(self.baseColor)
                    Rectangle()
                        .fill(returnRectanglerColor(runtime: value * TestUserDataView(currentDate: $cd).taskTime).opacity(0.5))
                        .frame(minWidth: 0, idealWidth:self.getProgressBarWidth(geometry: geometry),
                               maxWidth: self.getProgressBarWidth(geometry: geometry))
                        .cornerRadius(2)
                }
            }
        }
    }

    func getProgressBarWidth(geometry:GeometryProxy) -> CGFloat {
        let frame = geometry.frame(in: .global)
        return frame.size.width * value
    }
    
    // タスク実行バーの色を返す
    private func returnRectanglerColor(runtime: Double) -> Color {
        if runtime < TestUserDataView(currentDate: $cd).taskTime {
            return Color.red
            
        } else if runtime <= TestUserDataView(currentDate: $cd).taskTime * 1.5 {
            return Color.green
            
        } else {
            return Color.blue
            
        }
    }
}
