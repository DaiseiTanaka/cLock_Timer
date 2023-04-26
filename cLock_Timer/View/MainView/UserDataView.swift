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
        
    @State var showCharacterDetailView: Bool = false
    
    @State var showTimerSettingViewInUserDataView: Bool = false
    
    @State var achievenmentSelectedTab: Int = 0
    // Days
    //let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    private let days: [String] = ["日", "月", "火", "水", "木", "金", "土"]
    
    // calendar columns
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    // 画面の向きを制御
    @State var orientation: UIDeviceOrientation = .portrait
    @State var portraitOrNotFlag: Bool = true
    
    @State var screenWidth: CGFloat = UIScreen.main.bounds.width
    @State var screenHeight: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 15) {
                
                // 週間達成目標、達成度を表示
                weeklyDashboard
                
                // 年、月、月変更ボタン
                calendarHeaderView
                
                // 曜日表示
                dayView
                
                // カレンダー表示
                calendarView
                
            }
        }
        .padding(.horizontal, portraitOrNotFlag ? 3 : 30)
        .padding(.top, portraitOrNotFlag ? 0 : 10)
        // 画面の向きが変わったことを検知
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            orientation = UIDevice.current.orientation
        }
        // 画面の向きが変わった時の処理　.onReceive内で実行したら不具合があったため切り離した
        .onChange(of: orientation) { _ in
            portraitOrNotFlag = self.timeManager.returnOrientation()
            screenWidth = UIScreen.main.bounds.width
        }
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
        .sheet(isPresented: $showCharacterDetailView) {
            CharacterDetailView()
                .presentationDetents([.medium, .large])
        }
        .sheet(isPresented: $showTimerSettingViewInUserDataView) {
            TimerSettingView(taskName: self.timeManager.task)
                .presentationDetents([.large])
        }
    }
    
    // Calendar View
    var calendarView: some View {
        LazyVGrid(columns: columns, spacing: 3) {
            ForEach(extractDate()) { value in
                CardView(value: value)
                    .onTapGesture {
                        let impactLight = UIImpactFeedbackGenerator(style: .light)
                        impactLight.impactOccurred()
                        //withAnimation {
                            currentDate = value.date
                        //}
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
                                self.timeManager.returnRectanglerColor(runtime: task.runtime, opacity: 1.0)
                                    .cornerRadius(5)
                                    .frame(maxHeight: 20 + 15 * task.runtime / self.timeManager.taskTime)
                                
                            } else if task.runtime <= self.timeManager.taskTime * 1.5 {
                                self.timeManager.returnRectanglerColor(runtime: task.runtime, opacity: 1.0)
                                    .cornerRadius(5)
                                    .frame(maxHeight: 35 + 15 * (task.runtime - self.timeManager.taskTime) / (self.timeManager.taskTime * 0.5))
                                
                            } else {
                                self.timeManager.returnRectanglerColor(runtime: task.runtime, opacity: 1.0)
                                    .cornerRadius(5)
                                    .frame(maxHeight: 50)
                            }
                        }
                        
                        VStack {
                            Spacer()
                            Text("\(self.timeManager.runtimeToString(time: task.runtime, second: false, japanease: false, onlyMin: false))")
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
            thisWeekDashboardView
            
            Spacer(minLength: 0)
            
            HStack(spacing: 7) {
                    Spacer(minLength: 0)

                    TabView(selection: $achievenmentSelectedTab) {
                        ZStack {
                            HStack(spacing: 7) {
                                runtimeEverSumView
                                    .padding(7)
                                    .background(Color(UIColor.systemGray6))
                                    .cornerRadius(5)
                                                                
                                consecutiveDaysVkew
                                    .padding(7)
                                    .background(Color(UIColor.systemGray6))
                                    .cornerRadius(5)
                            }
                            
                            HStack {
                                Spacer(minLength: 0)
                                
                                Image(systemName: "chevron.compact.right")
                                    .font(.title.bold())
                                    .onTapGesture {
                                        let impactLight = UIImpactFeedbackGenerator(style: .light)
                                        impactLight.impactOccurred()
                                        withAnimation {
                                            self.achievenmentSelectedTab = 1
                                        }
                                    }
                                    .opacity(0.5)
                            }
                        }
                        .tag(0)
                        
                        ZStack {
                            achievementView
                            
                            HStack {
                                Image(systemName: "chevron.compact.left")
                                    .font(.title.bold())
                                    .onTapGesture {
                                        let impactLight = UIImpactFeedbackGenerator(style: .light)
                                        impactLight.impactOccurred()
                                        withAnimation {
                                            self.achievenmentSelectedTab = 0
                                        }
                                    }
                                    .opacity(0.5)
                                
                                Spacer(minLength: 0)
                            }
                        }
                        .tag(1)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                    .frame(height: 70)
                    
                    Spacer(minLength: 0)
                    
                    runtimeCircleView
                    
                    Spacer(minLength: 0)
                }
            
        }
        .padding(.top, 10)
    }
    
    // 今週の実績
    var thisWeekDashboardView: some View {
        HStack(spacing: 0) {
            VStack {
                Text("● 今週の実績")
                    .font(.caption)
                ZStack {
                    VStack(spacing: 0) {
                        Text("\(self.timeManager.runtimeToString(time: self.timeManager.thisWeekRuntimeSum, second: false, japanease: true, onlyMin: false))")
                            .font(.title3.bold())
                    }
                    .frame(width: 100, height: 100)
                    
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
                Text("● 目標: \(self.timeManager.runtimeToString(time: self.timeManager.taskTime * 7, second: false, japanease: true, onlyMin: false))")
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
                        Text("\(self.timeManager.runtimeToString(time: self.timeManager.thisWeekRuntimeList[num], second: false, japanease: true, onlyMin: true))")
                            .font(Font(UIFont.monospacedDigitSystemFont(ofSize: 10, weight: .medium)))
                            //.font(.caption2)
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
    }
    
    // 総タスク実行時間
    var runtimeEverSumView: some View {
        VStack {
            HStack {
                Image(systemName: "clock")
                    .font(.caption)
                Text("総タスク実行時間")
                    .font(.caption)
                Spacer(minLength: 0)
            }
            Spacer(minLength: 0)
            
            Text("\(self.timeManager.runtimeToString(time: self.timeManager.runtimeEverSum, second: false, japanease: true, onlyMin: false))")
                .font(.headline)
            Text("今月: \(self.timeManager.runtimeToString(time: self.timeManager.thisMonthRuntimeSum, second: false, japanease: true, onlyMin: false))")
                .font(.caption)
            
            //Spacer(minLength: 0)
        }
        
    }
    
    // タスク継続日数
    var consecutiveDaysVkew: some View {
        VStack {
            HStack {
                Image(systemName: "calendar")
                Text("継続日数")
                    .font(.caption)
                Spacer(minLength: 0)
            }
            Spacer(minLength: 0)
            Text("\(self.timeManager.recentConsecutiveDays)日")
                .font(.headline)
            Text("自己ベスト: \(self.timeManager.maxConsecutiveDays)日")
                .font(.caption)
        }
    }
    
    // 実行時間
    var runtimeCircleView: some View {
        ZStack {
            if let tasks = self.timeManager.tasks.first(where: { tasks in
                return isSameDay(date1: tasks.taskDate, date2: currentDate)
            }) {
                ZStack {
                    VStack {
                        Text(returnDateString(date: currentDate))
                            .font(.caption2.bold())
                            .foregroundColor(Color(UIColor.systemGray3))
                        Text("\(self.timeManager.runtimeToString(time: tasks.runtime, second: false, japanease: false, onlyMin: false))")
                            .font(.caption2.bold())
                    }
                    Circle()
                        .trim(from: 0.01, to: tasks.runtime / (self.timeManager.taskTime) - 0.01)
                        .stroke(self.timeManager.returnRectanglerColor(runtime: tasks.runtime, opacity: 1.0), style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                        .scaledToFit()
                        .rotationEffect(Angle(degrees: -90))
                        .frame(width: 55, height: 55)
                    Circle()
                        .stroke(Color.blue, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                        .scaledToFit()
                        .opacity(0.1)
                        .frame(width: 55, height: 55)
                }
                .onTapGesture {
                    // バイブレーション
                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                    impactLight.impactOccurred()
                    withAnimation {
                        if self.achievenmentSelectedTab == 0 {
                            self.achievenmentSelectedTab = 1
                        } else {
                            self.achievenmentSelectedTab = 0
                        }
                    }
                }
            } else {
                VStack {
                    Text(returnDateString(date: currentDate))
                        .font(.caption2.bold())
                        .foregroundColor(Color(UIColor.systemGray3))
                    Text("--:--")
                        .font(.footnote.bold())
                    
                }
                Circle()
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                    .scaledToFit()
                    .opacity(0.1)
                    .frame(width: 55, height: 55)
            }
        }

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
            
            // タスクを再設定
            Button {
                let impactLight = UIImpactFeedbackGenerator(style: .light)
                impactLight.impactOccurred()
                
                showTimerSettingViewInUserDataView = true
            } label: {
                Image(systemName: "slider.horizontal.3")
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
                VStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            VStack {
                                HStack {
                                    Text(returnDateString(date: tasks.taskDate))
                                        .font(.subheadline.bold())
                                    Text(tasks.task[0].title)
                                        .font(.subheadline.bold())
                                    Spacer(minLength: 0)
                                }
                                
                                Spacer(minLength: 0)
                                
                                HStack {
                                    Image(systemName: "flag.checkered")
                                        .font(.subheadline.bold())
                                        //.padding(.leading, 10)
                                    Text(" \( self.timeManager.runtimeToString(time: self.timeManager.taskTime, second: false, japanease: false, onlyMin: false))")
                                        .font(.subheadline)
                                    
                                    Image(systemName: "clock.badge")
                                        .font(.subheadline.bold())
                                    Text(String(format: "%02d:%02d~", self.timeManager.startHourSelection, self.timeManager.startMinSelection))
                                        .font(.subheadline)
                                    
                                    Spacer(minLength: 0)
                                }
                                //.padding(.top, 3)
                            }
                            .padding(.leading, 10)
                            
                        }
                    }
                    .padding(.vertical, 7)
                    .padding(.horizontal)
                    .background(
                        self.timeManager.returnRectanglerColor(runtime: tasks.runtime, opacity: 0.4)
                    )
                }
                .cornerRadius(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                //.padding()
            } else {
                Text("No data")
            }
        }
    }
    
    //@ViewBuilder
    //func timeLineView(runtime: Double) -> some View {
//    var timeLineView: some View {
//        if let tasks = self.timeManager.tasks.first(where: { tasks in
//            return isSameDay(date1: tasks.taskDate, date2: currentDate)
//        }) {
//            ZStack {
//                TimelineList(items: usedTimeData, dotColor: self.timeManager.returnRectanglerColor(runtime: tasks.runtime, opacity: 1.0))
//                    .frame(height: 250)
//                //.scrollDisabled(true)
//                    .scrollContentBackground(.hidden)
//                    .background(Color(UIColor.systemGray6))
//                    .onTapGesture {
//                        // バイブレーション
//                        let impactLight = UIImpactFeedbackGenerator(style: .light)
//                        impactLight.impactOccurred()
//
//                        withAnimation {
//                            //self.showTimelineView.toggle()
//                        }
//                    }
//            }
//            .cornerRadius(10)
//            .padding(.horizontal)
//        }
//    }
    
    // MARK: - 画面制御関連
    
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
    
    // 日付を○/○のようにして、Stringで返す
    private func returnDateString(date: Date) -> String {
        let dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let dateStr = "\(dateComp.month!)/\(dateComp.day!)"
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MM/dd"
//        let dateStr = formatter.string(from: date)
        
        return dateStr
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
