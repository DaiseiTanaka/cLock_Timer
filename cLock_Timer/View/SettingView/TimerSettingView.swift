//
//  SettingView.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/03/15.
//

import SwiftUI

struct TimerSettingView: View {
    //TimeManagerのインスタンスを作成
    @EnvironmentObject var timeManager: TimeManager
    
    // タスク名
    @State private var taskName = ""
    
    var body: some View {
        List {
            Section(header: Text("タスクの内容")) {
                TextField("タスクの内容を入力してください", text: self.$taskName)
            }
            
            Section(header: Text("タスクを行う時間")) {
                PickerView()
            }
            
            Section(header: Text("タスクを開始可能な時間")) {
                StartTimePickerView()
            }
            
            Section {
                Button(action: {
                    self.timeManager.setTimer()
                    self.timeManager.task = taskName
                    self.timeManager.showSettingView = false
                    self.timeManager.saveCoreData()
                    self.timeManager.saveUserData()
                }){
                    HStack {
                        Spacer()
                        Text("保存")
                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            print("✨TimerSettingView Appear")
            // タスク開始可能時間を自動でセット
            self.timeManager.getTime()
        }
    }
}
