//
//  TimeLineView.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/03/25.
//

import SwiftUI

struct TimeLineView: View {
    @EnvironmentObject var timeManager: TimeManager
    
    @State private var timeStrArray: [TimeStringArray] = []
    @State var inputUsedTimeArray: [Appointment]
    
    @State var usedAppArray: [[Date]] = []
    @State var usedTimerArray: [[Date]] = []
    
    let dotColor: Color
    private static let lineWidth: CGFloat = 2
    private static let dotDiameter: CGFloat = 8
    private static let rowHeight: CGFloat = 30
    
    var body: some View {
        ScrollView {
            ZStack {
                // 左側の時間軸
                timeStrView
                
                // 現在時刻のライン
                VStack(spacing: 0) {
                    horizontalLine(startHeight: returnStartHeight(date: Date()))
                    //horizontalLine(startHeight: 90)
                    
                    Spacer()
                }
                .padding(.leading, 60)
                
                // 右側のラインリスト
                HStack {
                    VStack(spacing: 0) {
                        ZStack {
                            //VStack(spacing: 0) {
                            if returnUsedDataArray(target: "app").count > 0 {
                                ForEach(0..<returnUsedDataArray(target: "app").count-1) { index in
                                    line(startHeight: returnStartHeight(date: returnUsedDataArray(target: "app")[index][0]),
                                         height: returnHeight(startDate: returnUsedDataArray(target: "app")[index][0], endDate: returnUsedDataArray(target: "app")[index][1]) )
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding(.leading, 70)
                    
                    VStack(spacing: 0) {
                        ZStack {
                            if returnUsedDataArray(target: "timer").count > 0 {
                                ForEach(0..<returnUsedDataArray(target: "timer").count-1) { index in
                                    line(startHeight: returnStartHeight(date: returnUsedDataArray(target: "timer")[index][0]), height: returnHeight(startDate: returnUsedDataArray(target: "timer")[index][0], endDate: returnUsedDataArray(target: "timer")[index][1]) )
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    Spacer()

                }
            }
            .onAppear {
//                usedAppArray = returnUsedDataArray(target: "app")
//                usedTimerArray = returnUsedDataArray(target: "timer")
                print(" TimeLineView appear. \n inputUsedTimeArray: \(inputUsedTimeArray) \n usedAppArray: \(usedAppArray) \n usedTimerArray: \(usedTimerArray)")
                returnDateArray()
                
            }
        }
    }
    
    @ViewBuilder private func line(startHeight: CGFloat, height: CGFloat) -> some View {
        let lineView = Rectangle()
            .foregroundColor(.black)
            .frame(width: TimeLineView.lineWidth)
        
        let dot = Circle()
            .fill(dotColor)
            .frame(width: TimeLineView.dotDiameter,
                   height: TimeLineView.dotDiameter)
        VStack(spacing: 0) {
            dot
            lineView
                .frame(height: height - TimeLineView.dotDiameter > 0 ? height - TimeLineView.dotDiameter : 0)
            dot
        }
        .offset(y: startHeight - TimeLineView.dotDiameter/2)
    }
    
    @ViewBuilder private func horizontalLine(startHeight: CGFloat) -> some View {
        let lineView = Rectangle()
            .foregroundColor(.black)
            .frame(height: TimeLineView.lineWidth)
        
        let dot = Circle()
            .fill(dotColor)
            .frame(width: TimeLineView.dotDiameter,
                   height: TimeLineView.dotDiameter)
        
        HStack(spacing: 0) {
            Spacer()
            dot
            lineView
                .frame(width:  UIScreen.main.bounds.width - 90)
            dot
            Spacer()
        }
        .offset(y: startHeight - TimeLineView.dotDiameter/2)
    }
    
    var timeStrView: some View {
        VStack(spacing: 0) {
            ForEach(timeStrArray, id: \.id) { timeStr in
                HStack {
                    Text(timeStr.time)
                        .font(Font(UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .medium)))
                        .foregroundColor(Color.gray)
                        .frame(minWidth: 60)

                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(Color(UIColor.systemGray))
                        .opacity(0.5)
                        
                }
                .frame(height: TimeLineView.rowHeight)
            }
        }
    }
    
    
    func returnUsedDataArray(target: String) -> [[Date]] {
        
        let array = inputUsedTimeArray
        
        var runningFlag: Bool = false
        var appearFlag: Bool = false
        
        var appearDate: Date = Date()
        var disapperDate: Date = Date()
        var runningDate: Date = Date()
        var stopDate: Date = Date()
        
        var appArray: [Date] = []
        var timerArray: [Date] = []
        
        var appReturnArray: [[Date]] = []
        var timerReturnArray: [[Date]] = []
        
        for num in 0..<array.count {
            let data = array[num]
            let title = data.message
            
            if title == "app_appear" {
                appearDate = data.date
                appearFlag = true
                
            } else if title == "app_disapper" && appearFlag {
                disapperDate = data.date
                appArray = [appearDate, disapperDate]
                appReturnArray.append(appArray)
                appearFlag = false
                
            } else if title == "start_timer" {
                runningDate = data.date
                runningFlag = true
                
            } else if title == "stop_timer" && runningFlag {
                stopDate = data.date
                timerArray = [runningDate, stopDate]
                timerReturnArray.append(timerArray)
                runningFlag = false
                
            }
        }
        
        
        if target == "app" {
            //print("appReturnArray: \(appReturnArray)")
            //usedAppArray = appReturnArray
            return appReturnArray
        } else {
            //print("timerReturnArray: \(timerReturnArray)")
            //usedTimerArray = timerReturnArray
            return timerReturnArray
        }
        
    }
    
    // ラインビューのスタート地点を返す
    private func returnStartHeight(date: Date) -> CGFloat {
        
        let dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

        let hour: Int = dateComp.hour!
        let min:  Int = dateComp.minute!
        
        let height = CGFloat(15 + hour * 30 + min / 2)
        
        print("returnStartHeight() hour: \(hour), min: \(min) startHeight: \(height)")
        return height
    }
    
    // ラインビューの長さを返す
    private func returnHeight(startDate: Date, endDate: Date) -> CGFloat {
        let startDateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: startDate)
        let endDateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: endDate)

        let startHour: Int = startDateComp.hour!
        let startMin:  Int = startDateComp.minute!
        let endHour: Int = endDateComp.hour!
        let endMin:  Int = endDateComp.minute!
        
        let hourDiff = endHour - startHour
        let minDiff  = endMin - startMin
        
        let height = CGFloat(hourDiff * 30 + minDiff / 2)
        
        print("\nreturnHeight() startHour: \(startHour), startMin: \(startMin), endHour: \(endHour), endMin: \(endMin), hourDiff: \(hourDiff), minDiff: \(minDiff), height: \(height)")
        return height
    }
    
    // 時刻の文字列を返す
    private func returnDateArray() {
        for num in 0..<24 {
            let inputStr = String("\(num):00")
            timeStrArray.append(TimeStringArray(time: inputStr))
        }
        //print(timeStrArray)
    }
}

struct TimeStringArray: Identifiable {
    var id = UUID()
    var time : String
}

//struct TimeLineView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimeLineView()
//            .environmentObject(TimeManager())
//    }
//}
