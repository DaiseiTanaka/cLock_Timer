//
//  PickerView.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/03/15.
//

import SwiftUI

struct PickerView: View {
    //TimeManagerのインスタンスを作成
    @EnvironmentObject var timeManager: TimeManager
    //設定可能な時間単位の数値
    var hours = [Int](0..<24)
    //設定可能な分単位の数値
    var minutes = [0, 1, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]
    
    var body: some View {
        ZStack{
            VStack {
                HStack(spacing: 0) {
                    //時間単位のPicker
                    Picker(selection: self.$timeManager.hourSelection, label: Text("minute")) {
                        ForEach(0 ..< self.hours.count) { index in
                            Text("\(self.hours[index])")
                                .tag(index)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .compositingGroup()
                    .clipped(antialiased: true)
                    //時間単位を表すテキスト
                    Text("hour")
                        .font(.headline)
                    
                    //分単位のPicker
                    Picker(selection: self.$timeManager.minSelection, label: Text("minute")) {
                        ForEach(0 ..< self.minutes.count) { index in
                            Text("\(self.minutes[index])")
                                .tag(self.minutes[index])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .compositingGroup()
                    .clipped(antialiased: true)
                    
                    //分単位を表すテキスト
                    Text("min")
                        .font(.headline)
                }
                .padding(.horizontal)
            }
        }
    }
}

// タップしてないところが動くのを防ぐ
extension UIPickerView {
    open override var intrinsicContentSize: CGSize {
        //return CGSize(width: 200, height: 160)
        return CGSize(width: UIView.noIntrinsicMetric - 50, height: 160)
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView()
            .environmentObject(TimeManager())
            .previewLayout(.sizeThatFits)
    }
}
