//
//  TestContentView.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/03/18.
//

import SwiftUI

struct TestContentView: View {
    //TimeManagerのインスタンスを作成
    @EnvironmentObject var timeManager: TimeManager
    @Environment(\.scenePhase) private var scenePhase
    
    @State var currentDate: Date = Date()
    
    var body: some View {
        TabView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    UserDataView(currentDate: $currentDate)
                }
                .padding(.horizontal, 3)
            }
            
            TaskView()

        }
        .tabViewStyle(PageTabViewStyle())
        .ignoresSafeArea()
        .statusBar(hidden: true)
        .onChange(of: scenePhase) { phase in
            if phase == .background {
                self.timeManager.setNotification()
                self.timeManager.saveUserData()
                print("バックグラウンド！")
            }
            if phase == .active {
                self.timeManager.removeNotification()
                self.timeManager.loadAllData()
                print("フォアグラウンド！")
            }
            if phase == .inactive {
                print("バックグラウンドorフォアグラウンド直前")
            }
        }
        .onAppear {
            //self.timeManager.removeAllUserDefaults()
        }
    }
}
