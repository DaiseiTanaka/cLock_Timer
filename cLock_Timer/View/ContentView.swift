//
//  ContentView.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/03/15.
//

import SwiftUI

struct ContentView: View {
    //TimeManagerのインスタンスを作成
    @EnvironmentObject var timeManager: TimeManager
    @Environment(\.scenePhase) private var scenePhase
    
    @State var currentDate: Date = Date()
    
    @State var loadContentView: Bool = true
    
    var body: some View {
        TabView {
            if !self.timeManager.showSettingView {
                if !loadContentView {
                    ScrollView(.vertical, showsIndicators: false) {
                        UserDataView(currentDate: $currentDate)
                            .id(0)
                    }
                    
                    TaskView()
                        .id(1)
                } else {
                    ProgressView()
                }
            } else {
                TimerSettingView()
                    .id(2)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .ignoresSafeArea()
        .statusBar(hidden: true)
        .onChange(of: scenePhase) { phase in
            if phase == .background {
                print("\nバックグラウンド！")
                self.timeManager.setNotification()
                self.timeManager.saveTimeCalendarData(title: "app_disapper")
                self.timeManager.saveUserData()
                
            }
            if phase == .active {
                print("\nフォアグラウンド！")
                loadContentView = true
                
                self.timeManager.removeNotification()
                self.timeManager.loadAllData()
                self.timeManager.saveTimeCalendarData(title: "app_appear")
                // 今週のデータを更新
                self.timeManager.loadWeeklyDashboardData()
                // キャラクターを更新
                self.timeManager.loadSelectedCharacterData()
                
                loadContentView = false
            }
            if phase == .inactive {
                print("\nバックグラウンドorフォアグラウンド直前")
            }
        }
        .onAppear {
            //self.timeManager.removeAllUserDefaults()
        }
    }
    
    private func testDateFunc() {
        let now = Date()
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ja_JP")
        let nowDate = calendar.date(byAdding: .hour, value: 9, to: now)!

        let day = calendar.component(.day, from: Date())
        let hour = calendar.component(.hour, from: Date())
        let min = calendar.component(.minute, from: Date())
        let sec = calendar.component(.second, from: Date())
        
        print(nowDate)
        print("\(day) \(hour) \(min) \(sec)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TimeManager())
    }
}
