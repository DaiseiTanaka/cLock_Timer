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
    @Environment(\.dismiss) var dismiss

    // タスク名
    @State var taskName: String
    
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
                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                    impactLight.impactOccurred()
                    
                    self.timeManager.setTimer()
                    self.timeManager.task = taskName
                    self.timeManager.showSettingView = false
                    self.timeManager.saveCoreData()
                    self.timeManager.saveUserData()
                    dismiss()
                }){
                    HStack {
                        Spacer()
                        Text("保存")
                        Spacer()
                    }
                }
            }
            
            Section {
                Button(action: {
                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                    impactLight.impactOccurred()
                    
                    self.timeManager.showSettingView = false
                    dismiss()
                }){
                    HStack {
                        Spacer()
                        Text("キャンセル")
                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            print("✨TimerSettingView Appear")
            // タスク開始可能時間を自動でセット
            self.timeManager.getTime()
            taskName = self.timeManager.task
        }
    }
}
