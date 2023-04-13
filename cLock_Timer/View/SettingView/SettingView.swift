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
    
    @State var showDeleteAllDataAlart = false
    @State var showDeleteAllCharacterAlart = false
    
    var body: some View {
        List {
            Section(header: Text("一般設定")) {
                Toggle("ステータスバーを非表示にする", isOn: self.$timeManager.showStatusBarFlag)
                
            }
            
            Section(header: Text("タイマー画面設定")) {
                Toggle("タイマーを自動更新する", isOn: self.$timeManager.autoRefreshFlag)
                
                Toggle("タスク名を表示する", isOn: self.$timeManager.showTaskFlag)
                
                Toggle("育成中のキャラクターを表示する", isOn: self.$timeManager.showCharacterFlag)
            }
            
            Section(header: Text("タスクの再設定"), footer: Text("タスク内容、時間、開始時間を再設定します。")) {
                Button(action: {
                    self.timeManager.showSettingView = true
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
                    showDeleteAllCharacterAlart = true
                    
                }){
                    HStack {
                        Spacer()
                        Text("キャラクターのデータを初期化する")
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
                .alert(isPresented: $showDeleteAllCharacterAlart) {
                    Alert(
                        title: Text("所持済みキャラクターのデータを削除する"),
                        message: Text("この操作は取り消すことができません。"),
                        primaryButton: .cancel(Text("キャンセル")),
                        secondaryButton: .destructive(Text("削除"), action: {
                            let impactLight = UIImpactFeedbackGenerator(style: .light)
                            impactLight.impactOccurred()
                            //　所持済みキャラクターのデータを削除する
                            UserDefaults.standard.removeObject(forKey: "possessionList")
                            self.timeManager.possessionList = [:]
                            self.timeManager.expTime = 0
                            self.timeManager.selectedCharacter = self.timeManager.selectNewCharacter()
                            self.timeManager.loadSelectedCharacterData()
                            self.timeManager.loadCharacterDetailData(selectedDetailCharacter: self.timeManager.selectedCharacter)
                            
                            showDeleteAllCharacterAlart = false
                            dismiss()
                        })
                    )
                }
            }
            
            Button(action: {
                showDeleteAllDataAlart = true
                
            }){
                HStack {
                    Spacer()
                    Text("全てのデータを削除する")
                        .foregroundColor(.red)
                    Spacer()
                }
            }
            .alert(isPresented: $showDeleteAllDataAlart) {
                Alert(
                    title: Text("全てのデータを削除する"),
                    message: Text("この操作は取り消すことができません。"),
                    primaryButton: .cancel(Text("キャンセル")),
                    secondaryButton: .destructive(Text("削除"), action: {
                        let impactLight = UIImpactFeedbackGenerator(style: .light)
                        impactLight.impactOccurred()
                        // 基礎データを初期化
                        self.timeManager.removeAllUserDefaults()
                        self.timeManager.showSettingView = true
                        self.timeManager.resetPicker()
                        self.timeManager.runtime = 0
                        self.timeManager.duration = self.timeManager.taskTime
                        self.timeManager.tasks = []
                        
                        // キャラクター関連
                        UserDefaults.standard.removeObject(forKey: "possessionList")
                        self.timeManager.possessionList = [:]
                        self.timeManager.expTime = 0
                        self.timeManager.selectedCharacter = self.timeManager.selectNewCharacter()
                        self.timeManager.loadSelectedCharacterData()
                        self.timeManager.loadCharacterDetailData(selectedDetailCharacter: self.timeManager.selectedCharacter)
                        
                        print("⚠️⚠️⚠️全てのデータが削除されました。⚠️⚠️⚠️")
                        showDeleteAllDataAlart = false
                        dismiss()
                        
                    })
                )
            }
        }
        .onDisappear {
            self.timeManager.saveCoreData()
        }
    }
}
