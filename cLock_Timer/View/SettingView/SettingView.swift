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
            Section(header: Text("タイマー設定")) {
                Toggle("タイマーを自動更新する", isOn: self.$timeManager.autoRefreshFlag)
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
