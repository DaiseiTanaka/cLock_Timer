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
    
    var body: some View {
        TabView {
            if !self.timeManager.showSettingView {
                ScrollView(.vertical, showsIndicators: false) {

                    UserDataView(currentDate: $currentDate)
                        .id(0)
                }
                
                TaskView()
                    .id(1)

            } else {
                TimerSettingView()
                    
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .ignoresSafeArea()
        .statusBar(hidden: true)
        .onChange(of: scenePhase) { phase in
            if phase == .background {
                self.timeManager.setNotification()
                self.timeManager.saveUserData()
                print("\nバックグラウンド！")
            }
            if phase == .active {
                self.timeManager.removeNotification()
                self.timeManager.loadAllData()
                // 今週のデータを更新
                self.timeManager.loadWeeklyDashboardData()
                print("\nフォアグラウンド！")
            }
            if phase == .inactive {
                print("\nバックグラウンドorフォアグラウンド直前")
            }
        }
        .onAppear {
            //self.timeManager.removeAllUserDefaults()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TimeManager())
    }
}
