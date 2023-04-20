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
    
    @State var prevScenePhase: String = "バックグラウンド"
    // ポイント利用画面表示フラグ
    @State var showPointView: Bool = false
    
    
    var body: some View {
        ZStack {
            if self.timeManager.showSettingView {
                TimerSettingView(taskName: self.timeManager.task)

            } else if self.timeManager.showGachaView {
                GachaView()
                
            } else {
                if !loadContentView {
                    TabView(selection: self.$timeManager.selectTabIndex) {
                        ZStack {
                            UserDataView(currentDate: $currentDate)
                                
                            FloatingButton
                                .opacity(0.8)
                        }
                        .tag(0)
                        .tabItem {
                            Image(systemName: "calendar")
                                .bold()
                            Text("データ")
                        }
                        
                        CharacterDetailView()
                        .tag(2)
                        .tabItem {
                            Image(systemName: "hare")
                                .bold()
                            Text("キャラクター")
                        }
                        
                        ZStack {
                            TaskView()
                            if self.timeManager.showPointFloatingButton {
                                FloatingButton
                                    .opacity(0.8)
                            }
                        }
                        .tag(1)
                        .tabItem {
                            Image(systemName: "timer")
                                .bold()
                            Text("タイマー")
                        }
                        
                        PointView()
                        .tag(3)
                        .tabItem {
                            Image(systemName: "p.circle")
                                .bold()
                            Text("ポイント")
                        }
                        
                        SettingView()
                            .tag(4)
                            .tabItem {
                                Image(systemName: "slider.horizontal.3")
                                    .bold()
                                Text("設定")
                            }
                    }
                    
                } else {
                    ProgressView()
                    
                }
            }
        }
        .ignoresSafeArea()
        .statusBar(hidden: self.timeManager.showStatusBarFlag)
        .sheet(isPresented: $showPointView) {
            PointView()
                .presentationDetents([.medium, .large])
        }
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
    
    // ポイント確認用ボタン
    var FloatingButton: some View {
        VStack {
            Spacer()
            HStack(spacing: 0) {
                Spacer()
                Button(action: {
                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                    impactLight.impactOccurred()
                    withAnimation {
                        self.timeManager.pointFloatingButtonToSmall.toggle()
                    }
                }){
                    HStack {
                        Spacer(minLength: 0)
                        Image(systemName: self.timeManager.pointFloatingButtonToSmall ? "chevron.compact.left" : "chevron.compact.right")
                            .resizable()
                            .scaledToFit()
                            .font(.system(size: 30).bold())
                            .foregroundColor(Color.gray)
                            .shadow(radius: 5)
                        Spacer(minLength: 0)
                    }
                    .frame(width: 40, height: 30)
                }
                
                Button(action: {
                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                    impactLight.impactOccurred()
                    
                    self.showPointView = true
                }){
                    HStack(spacing: 0) {
                        if self.timeManager.pointFloatingButtonToSmall {
                            Image(systemName: "p.circle")
                                //.font(.largeTitle.bold())
                                .font(.system(size: 30).bold())
                                .foregroundColor(.white)
                        } else {
                            Text("Eggいポイント ")
                                .font(Font(UIFont.monospacedDigitSystemFont(ofSize: 17, weight: .black)))
                                .foregroundColor(.white)
                            
                            Text("\(Int(self.timeManager.eggPoint))Pt")
                                .font(Font(UIFont.monospacedDigitSystemFont(ofSize: 17, weight: .medium)))
                                .foregroundColor(.white)
                                
                        }
                    }
                    .padding(self.timeManager.pointFloatingButtonToSmall ? 5 : 10)
                    .padding(.vertical, self.timeManager.pointFloatingButtonToSmall ? 0 : 3)
                    .background(
                        Color.green
                            .cornerRadius(20)
                            .shadow(radius: 10)
                    )
                }
            }
        }
        .padding(.bottom, 20)
        .padding(.trailing, 10)
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
