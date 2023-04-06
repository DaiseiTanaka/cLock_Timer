//
//  TaskView.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/03/15.
//

import SwiftUI

struct TaskView: View {
    //TimeManagerのインスタンスを作成
    @EnvironmentObject var timeManager: TimeManager
    @Environment(\.scenePhase) private var scenePhase

    
    @State private var showSettingView: Bool = false
    @State private var showTaskView: Bool = false
    
    @State private var loadTaskView: Bool = true
    
    @State private var imageSize: CGFloat = 150
    
    var body: some View {
        
        ZStack {
            if loadTaskView {
                
                ProgressView()
                
            } else {
                Color(UIColor.systemBackground)
                    .onTapGesture {
                        if !self.timeManager.autoRefreshFlag {
                            // バイブレーション
                            let impactLight = UIImpactFeedbackGenerator(style: .light)
                            impactLight.impactOccurred()
                            
                            // 画面をタップするとカウントダウンタイマーのUIを更新する
                            self.timeManager.updateTimer()
                        }
                    }
                
                // タイマー
                VStack {
                    Spacer()
                    
                    if self.timeManager.showCharacterFlag {
                        Image(self.timeManager.selectedCharacterImageName)
                            .resizable()
                            .frame(width: imageSize, height: imageSize)
                            .shadow(color: .black.opacity(0.3), radius: 5)
                    }
                    
                    if self.timeManager.task != "" && self.timeManager.showTaskFlag {
                        Text("\(self.timeManager.task)")
                            .font(.system(size: 40))
                            .foregroundColor(Color(UIColor.systemGray4))
                            .padding(.bottom, 20)
                    }
                    
                    if self.timeManager.autoRefreshFlag {
                        Text(self.timeManager.displayTimer())
                            .font(Font(UIFont.monospacedDigitSystemFont(ofSize: 70, weight: .medium)))
                        //.font(.system(size: 80))
                        Text("Total. \(self.timeManager.runtimeToString(time: self.timeManager.runtime, second: true))")
                            .font(Font(UIFont.monospacedDigitSystemFont(ofSize: 30, weight: .regular)))
                        //.font(.system(size: 30))
                            .foregroundColor(Color(UIColor.systemGray4))
                            .padding(.top, self.timeManager.task == "" ? 0 : 20)
                        
                    } else {
                        Text("\(self.timeManager.updatedTimer)")
                        //.font(.system(size: 80))
                            .font(Font(UIFont.monospacedDigitSystemFont(ofSize: 70, weight: .medium)))
                    }
                    
                    Spacer()
                }
                
                // 設定ボタン
                settingButton
                
            }
        }
        .ignoresSafeArea()
        .onAppear {
            print("\n✨ TaskView Appear")
            loadTaskView = true
            
            self.timeManager.start()
            self.timeManager.updateTimer()
            //self.timeManager.saveTimeCalendarData(title: "start_timer")
            showTaskView = true
            
            loadTaskView = false
        }
        .onDisappear {
            print("\n🌕 TaskView Disappear")
            //self.timeManager.pause()
            // データ更新
            self.timeManager.saveUserData()
            self.timeManager.timerStatus = .stopped
            //self.timeManager.saveTimeCalendarData(title: "stop_timer")
            // キャラクターを更新
            self.timeManager.loadSelectedCharacterData()
            
            showTaskView = false
            
        }
        .sheet(isPresented: self.$showSettingView) {
            SettingView()
        }
        .onReceive(timeManager.timer) { _ in
            //タイマーステータスが.stoppedの場合何も実行しない
            guard self.timeManager.timerStatus != .stopped else {
                return
            }
            
            //残り時間が0より大きい場合
            if self.timeManager.duration > 0 {
                //残り時間から -0.05 する
                self.timeManager.duration -= 1
                self.timeManager.timerStatus = .running
            } else {
                // タイマーステータスを.excessに変更する
                self.timeManager.timerStatus = .excess
            }
            
            // タスク実行中に日を跨いだ時に実行
            let tasks = self.timeManager.tasks
            
            if tasks.count != 0 {
                let lastdayDC = Calendar.current.dateComponents([.year, .month, .day], from: tasks[tasks.count - 1].taskDate)
                let todayDC = Calendar.current.dateComponents([.year, .month, .day], from: Date())
                
                if lastdayDC.day != todayDC.day {
                    print("日付が変わりました。")
                    //self.timeManager.saveTimeCalendarData(title: "stop_timer")
                    self.timeManager.saveUserData()
                    //self.timeManager.saveTimeCalendarData(title: "start_timer")
                }
            }
            
            // 一分おきにタスク画面に表示されているキャラクターをロードする
            if Int(self.timeManager.expTime) % 30 == 0 && self.timeManager.showCharacterFlag {
                self.timeManager.loadSelectedCharacterData()
            }
            
            // タスク実行時間を計測
            self.timeManager.runtime += 1
            
            // キャラクター経験値加算
            self.timeManager.expTime += 1
        }
        .onChange(of: scenePhase) { phase in
            if showTaskView {
                if phase == .inactive {
                    //print("scenePhase")
                    //self.timeManager.saveTimeCalendarData(title: "stop_timer")
                    self.timeManager.saveUserData()
                }
                if phase == .active {
                    //print("scenePhase")
                    //self.timeManager.saveTimeCalendarData(title: "start_timer")
                }
            }
        }
    }
    
    var settingButton: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "gear")
                    .padding(.top, 50)
                    .padding(.trailing, 20)
                    .font(.title)
                    .onTapGesture {
                        // バイブレーション
                        let impactLight = UIImpactFeedbackGenerator(style: .light)
                        impactLight.impactOccurred()
                        
                        self.showSettingView = true
                    }
                    .foregroundColor(Color.blue)
            }
            Spacer()
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
            .environmentObject(TimeManager())
    }
}
