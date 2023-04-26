//
//  ContentView.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/03/15.
//

import SwiftUI
//import SkeletonView


struct ContentView: View {
    //TimeManagerのインスタンスを作成
    @EnvironmentObject var timeManager: TimeManager
    @Environment(\.scenePhase) private var scenePhase
    
    @State var currentDate: Date = Date()
    
    @State var loadContentView: Bool = true
    
    @State var prevScenePhase: String = "バックグラウンド"
    
    @State var defaultSelection: Int = 1
    
    
    var body: some View {
        ZStack {
            if self.timeManager.showSettingView {
                TimerSettingView(taskName: self.timeManager.task)

            } else if self.timeManager.showGachaView {
                GachaView()
                
            } else {
                if !loadContentView {
                    MainContentView()
                    
                } else {
                    DemoView()
                    .redacted(reason: loadContentView ? .placeholder : [])

                    //ProgressView()
                }
            }
        }
        .ignoresSafeArea()
        .statusBar(hidden: self.timeManager.showStatusBarFlag)
        .onChange(of: scenePhase) { phase in
            if phase == .background {
                print("\nバックグラウンド！")
                self.timeManager.setNotification()
                self.timeManager.saveTimeCalendarData(title: "app_disapper")
                self.timeManager.saveCoreData()
                self.timeManager.saveUserData()
                prevScenePhase = "バックグラウンド"
            }
            if phase == .active {
                print("\nフォアグラウンド！")
                if prevScenePhase == "バックグラウンド" {
                    loadContentView = true
                    
                    self.timeManager.removeNotification()
                    self.timeManager.loadAllData()
                    self.timeManager.saveTimeCalendarData(title: "app_appear")
                    // 今週のデータを更新
                    self.timeManager.loadWeeklyDashboardData()
                    // キャラクターを更新
                    self.timeManager.loadSelectedCharacterData()
                    //
                    self.timeManager.loadCharacterDetailData(selectedDetailCharacter: self.timeManager.selectedCharacter)

                    
                    loadContentView = false
                }
                prevScenePhase = "フォアグラウンド"

            }
            if phase == .inactive {
                print("\nバックグラウンドorフォアグラウンド直前")
            }
        }
        .onAppear {
            //self.timeManager.removeAllUserDefaults()
            UIApplication.shared.isIdleTimerDisabled = true
            
            // TabViewの詳細設定
            let appearance = UITabBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            //appearance.backgroundColor = UIColor(Color.gray.opacity(0.2))
            
            // Use this appearance when scrolling behind the TabView:
            UITabBar.appearance().standardAppearance = appearance
            // Use this appearance when scrolled all the way up:
            UITabBar.appearance().scrollEdgeAppearance = appearance
            
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
