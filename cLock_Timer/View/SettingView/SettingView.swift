//
//  SettingView.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/03/15.
//

import SwiftUI

struct SettingView: View {
    //TimeManagerのインスタンスを作成
    @EnvironmentObject var timeManager: TimeManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List {
            Section(header: Text("タイマー表示設定")) {
                Toggle("タイマーを自動更新する", isOn: self.$timeManager.autoRefreshFlag)
                
                Toggle("タスク名を表示する", isOn: self.$timeManager.showTaskFlag)
            }
            
            Section(header: Text("タスクの再設定")) {
                Button(action: {
                    self.timeManager.showSettingView = true
                    self.timeManager.resetPicker()
                    dismiss()
                }){
                    HStack {
                        Spacer()
                        Text("タスクを再設定する")
                        Spacer()
                    }
                }
            }
            Section(header: Text("データ管理")) {
                Button(action: {
                    self.timeManager.removeAllUserDefaults()
                    self.timeManager.showSettingView = true
                    self.timeManager.resetPicker()
                    self.timeManager.runtime = 0
                    self.timeManager.duration = self.timeManager.taskTime
                    self.timeManager.tasks = []
                    dismiss()
                    print("⚠️⚠️⚠️全てのデータが削除されました。⚠️⚠️⚠️")
                }){
                    HStack {
                        Spacer()
                        Text("全てのデータを削除する")
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
            }
            
            Button(action: {
                dismiss()
            }){
                HStack {
                    Spacer()
                    Text("閉じる")
                    Spacer()
                }
            }
        }
    }
}
