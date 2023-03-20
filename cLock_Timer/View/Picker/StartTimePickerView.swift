//
//  StartTimePickerView.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/03/15.
//

import SwiftUI

struct StartTimePickerView: View {
    //TimeManagerのインスタンスを作成
    @EnvironmentObject var timeManager: TimeManager
    //設定可能な時間単位の数値
    let hours = [Int](0..<24)
    //設定可能な分単位の数値
    let minutes = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]
    
    var body: some View {
        ZStack{
            VStack {
                //時間、分、秒のPickerとそれぞれの単位を示すテキストをHStackで横並びに
                HStack(spacing: 0) {
                    //時間単位のPicker
                    Picker(selection: self.$timeManager.startHourSelection, label: Text("時間")) {
                        ForEach(0 ..< self.hours.count) { index in
                            // 一桁の数値の時には文頭に0を追加する
                            if self.hours[index] < 10 {
                                Text("0\(self.hours[index])")
                                    .tag(index)
                            } else {
                                Text("\(self.hours[index])")
                                    .tag(index)
                            }
                           
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .compositingGroup()
                    .clipped(antialiased: true)
                    Text(":")
                        .font(.headline)
                    
                    //分単位のPicker
                    Picker(selection: self.$timeManager.startMinSelection, label: Text("分")) {
                        ForEach(0 ..< self.minutes.count) { index in
                            // 一桁の数値の時には文頭に0を追加する
                            if self.minutes[index] < 10 {
                                Text("0\(self.minutes[index])")
                                    .tag(self.minutes[index])
                            } else {
                                Text("\(self.minutes[index])")
                                    .tag(self.minutes[index])
                            }
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .compositingGroup()
                    .clipped(antialiased: true)
                    
                }
                .padding(.horizontal)
            }
        }
    }
}

struct StartTimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        StartTimePickerView()
            .environmentObject(TimeManager())
            .previewLayout(.sizeThatFits)
    }
}

