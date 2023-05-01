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
    
    @State var showHowToUseView = false
    
    @State var miniImageSize: CGFloat = 20
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("一般設定")) {
                    HStack {
                        Image(systemName: "door.garage.double.bay.open")
                            .resizable()
                            .scaledToFit()
                            .frame(width: miniImageSize, height: miniImageSize)
                        Toggle("ステータスバーを非表示にする", isOn: self.$timeManager.showStatusBarFlag)
                    }
                }
                
                Section(header: Text("タイマー画面表示関連")) {
                    HStack {
                        Image(systemName: "clock.arrow.2.circlepath")
                            .resizable()
                            .scaledToFit()
                            .frame(width: miniImageSize, height: miniImageSize)
                        Toggle("タイマー表示を自動更新", isOn: self.$timeManager.autoRefreshFlag)
                    }
                    HStack {
                        Image(systemName: "hare")
                            .resizable()
                            .scaledToFit()
                            .frame(width: miniImageSize, height: miniImageSize)
                        Toggle("キャラクターを非表示", isOn: self.$timeManager.notShowCharacterFlag)
                    }
                    HStack {
                        Image(systemName: "ellipsis.curlybraces")
                            .resizable()
                            .scaledToFit()
                            .frame(width: miniImageSize, height: miniImageSize)
                        Toggle("タスク名を非表示", isOn: self.$timeManager.notShowTaskFlag)
                    }
                    HStack {
                        Image(systemName: "hourglass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: miniImageSize, height: miniImageSize)
                        Toggle("合計時間を非表示", isOn: self.$timeManager.notShowTotalTimeFlag)
                    }
                }
                
                Section(header: Text("ポイント関連"), footer: Text("⚪︎「貯蓄モード」は獲得したポイントを全て貯蓄します。貯めたポイントはポイント画面からいつでも利用できます。\n⚪︎「自動育成モード」は獲得したポイントを全てキャラクター育成に利用します。また育成に際し超過したポイントは自動で貯蓄されます。\n⚪︎「自動育成&貯蓄モード」はキャラクター育成とポイント貯蓄を交互に行い、キャラクターを育成しながらポイントを貯めることができます。")) {
                    HStack {
                        Image(systemName: "brain.head.profile")
                            .resizable()
                            .scaledToFit()
                            .frame(width: miniImageSize, height: miniImageSize)
                        Picker(selection: self.$timeManager.selectedUsePointMode,
                               label: Text("ポイント運用先")) {
                            ForEach(0..<self.timeManager.usePointMode.count) { index in
                                Text(self.timeManager.usePointMode[index]).tag(index)
                            }
                        }
                               .pickerStyle(.navigationLink)
                    }
                }
                
                Section(header: Text("使い方")) {
                    Button(action: {
                        showHowToUseView = true
                        dismiss()
                    }){
                        HStack {
                            Spacer()
                            Image(systemName: "questionmark.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: miniImageSize, height: miniImageSize)
                            Text("使い方を確認する")
                            Spacer()
                        }
                    }
                }
                
                Section(header: Text("タスクの再設定"), footer: Text("タスク内容、時間、開始時間を再設定します。")) {
                    Button(action: {
                        self.timeManager.showSettingView = true
                        dismiss()
                    }){
                        HStack {
                            Spacer()
                            Image(systemName: "slider.horizontal.2.gobackward")
                                .resizable()
                                .scaledToFit()
                                .frame(width: miniImageSize, height: miniImageSize)
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
                            Image(systemName: "exclamationmark.triangle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: miniImageSize, height: miniImageSize)
                                .foregroundColor(.red)
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
                        Image(systemName: "exclamationmark.triangle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: miniImageSize, height: miniImageSize)
                            .foregroundColor(.red)
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
                            self.timeManager.eggPoint = 0
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
            .sheet(isPresented: self.$showHowToUseView) {
                HowToUseView()
            }
            .onDisappear {
                self.timeManager.saveCoreData()
            }
            .navigationTitle("設定")
        }
    }
}
