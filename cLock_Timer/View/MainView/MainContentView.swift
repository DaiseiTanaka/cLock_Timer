//
//  MainView.swift
//  cLock_Timer
//
//  Created by 田中大誓 on 2023/04/21.
//

import SwiftUI


struct MainContentView: View {
    @EnvironmentObject var timeManager: TimeManager
    
    @State var currentDate: Date = Date()
    // ポイント利用画面表示フラグ
    @State var showPointView: Bool = false
    
    var body: some View {
        TabView(selection: self.$timeManager.selectTabIndex) {
            ZStack {
                UserDataView(currentDate: $currentDate)
                
//                FloatingButton
//                    .opacity(0.8)
            }
            .tag(0)
            .tabItem {
                Image(systemName: "calendar")
                Text("データ")
            }
            
            CharacterDetailView()
                .tag(2)
                .tabItem {
                    Image(systemName: "hare")
                    Text("キャラクター")
                }
            
            ZStack {
                TaskView()
                
                FloatingButton
                    .opacity(0.8)
            }
            .tag(1)
            .tabItem {
                Image(systemName: "timer")
                Text("タイマー")
            }
            
            PointView()
                .tag(3)
                .tabItem {
                    Image(systemName: "p.circle")
                    Text("ポイント")
                }
            
            SettingView()
                .tag(4)
                .tabItem {
                    Image(systemName: "slider.horizontal.3")
                    Text("設定")
                }
        }
        .sheet(isPresented: $showPointView) {
            MiniPointView()
                .presentationDetents([.fraction(0.45)])
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
                            .foregroundColor(Color(UIColor.systemGray3))
                            .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 10)
                            .padding(.trailing, 10)
                    }
                    .frame(width: 100, height: 30)
                }
                
                Button(action: {
                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                    impactLight.impactOccurred()
                    
                    self.showPointView = true
                }){
                    HStack(spacing: 0) {
                        if self.timeManager.pointFloatingButtonToSmall {
                            Image(systemName: "p.circle")
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
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                    )
                }
            }
        }
        .padding(.bottom, 20)
        .padding(.trailing, 10)
    }
    
}
