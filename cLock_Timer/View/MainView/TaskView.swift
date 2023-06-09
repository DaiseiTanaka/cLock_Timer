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

    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    @State private var showCharacterDetailView: Bool = false
    
    @State private var showTaskView: Bool = false
    
    @State private var loadTaskView: Bool = true
    // タイマー画面を表示
    @State private var showTimerView: Bool = false
    
    // キャラクター画像のサイズ
    @State private var imageSize: CGFloat = UIScreen.main.bounds.width * 0.7
    //　タスク名のフォントのサイズ
    @State private var titleFontSize: CGFloat = 35
    //　タイマーのフォントのサイズ
    @State private var timerFontSize: CGFloat = 55
    //　合計タスク実行時間のフォントのサイズ
    @State private var totalTimeFontSize: CGFloat = 30
    
    @State private var timerString: String = ""
    //@AppStorage("timerString") var timerString = ""
    @State private var totalTimerString: String = ""
    
    // 画面の向きを制御
    @State var orientation: UIDeviceOrientation
    @State var portraitOrNotFlag: Bool = true
    
    init() {
        self._orientation = State(wrappedValue: UIDevice.current.orientation)
    }
    
    var body: some View {
        
        ZStack {
            if loadTaskView {
                
                ProgressView()
                
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    // 縦画面
                    if portraitOrNotFlag {
                        VStack(spacing: 20) {
                            Spacer(minLength: 0)
                            
                            if !self.timeManager.notShowCharacterFlag {
                                characterImageViewAndCircle
                            }
                            
                            if self.timeManager.task != "" && !self.timeManager.notShowTaskFlag {
                                taskNameView
                            }
                            
                            timerView
                            
                            Spacer(minLength: 0)
                        }
                        .onTapGesture {
                            viewTappedAction()
                        }
                        .frame(width: min(screenWidth, screenHeight), height: max(screenWidth, screenHeight))
                        // 横画面
                    } else {
                        HStack(spacing: 40) {
                            Spacer()
                            
                            if !self.timeManager.notShowCharacterFlag {
                                characterImageViewAndCircle
                            }
                            
                            VStack(spacing: 0) {
                                if self.timeManager.task != "" && !self.timeManager.notShowTaskFlag {
                                    taskNameView
                                }
                                
                                timerView
                            }
                            
                            Spacer()
                        }
//                        .onTapGesture {
//                            viewTappedAction()
//                        }
                        .frame(width: max(screenWidth, screenHeight), height: min(screenWidth, screenHeight))
                        
                    }
                }
                .onTapGesture {
                    viewTappedAction()
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        let impactLight = UIImpactFeedbackGenerator(style: .light)
                        impactLight.impactOccurred()
                        //タイマー画面を表示
                        showTimerView = true
                    }){
                        HStack {
                            Spacer()
                            
                            Image(systemName: "infinity.circle.fill")
                                .resizable()
                                .foregroundColor(Color.gray)
                                .frame(width: 30, height: 30)
                                .padding(.top, 50)
                                .padding(.trailing, 20)
                        }
                    }
                }
                Spacer()
            }
            
            Color(UIColor.systemBackground)
                .onTapGesture {
                    viewTappedAction()
                }
                .opacity(0.01)
        }
        .ignoresSafeArea()
        .onAppear {
            print("\n✨ TaskView Appear")
            loadTaskView = true
           
            portraitOrNotFlag = self.timeManager.returnOrientation()
            
            // タイマーを開始
            self.timeManager.start()
            
            self.timeManager.setTimer()

            // タイマー表示用のテキストを更新
            self.timerString = self.timeManager.displayTimer()
            self.totalTimerString = self.timeManager.runtimeToString(time: self.timeManager.runtime, second: true, japanease: false, onlyMin: false)
            
            self.timeManager.updateTimer()
            //self.timeManager.saveTimeCalendarData(title: "start_timer")
            //showTaskView = true
            
            
            loadTaskView = false
        }
        .onDisappear {
            print("\n🌕 TaskView Disappear")
            // データ更新
            self.timeManager.saveUserData()
            self.timeManager.timerStatus = .stopped
            //self.timeManager.saveTimeCalendarData(title: "stop_timer")
            // キャラクターを更新
            self.timeManager.loadSelectedCharacterData()
            
            //showTaskView = false
            
        }
        // タイマー制御
        .onReceive(self.timeManager.timer) { _ in
            self.timeManager.countDownTimer()
        }
        // 画面の向きが変わったことを検知
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            orientation = UIDevice.current.orientation
        }
        // 画面の向きが変わった時の処理　.onReceive内で実行したら不具合があったため切り離した
        .onChange(of: orientation) { _ in
            portraitOrNotFlag = self.timeManager.returnOrientation()
        }
        .sheet(isPresented: $showCharacterDetailView) {
            CharacterDetailView()
                .presentationDetents([.large])
        }
        .fullScreenCover(isPresented: $showTimerView) {
            TimerView()
        }
//        .onChange(of: scenePhase) { phase in
//            if showTaskView {
//                if phase == .inactive {
//                    //print("scenePhase")
//                    //self.timeManager.saveTimeCalendarData(title: "stop_timer")
//                    self.timeManager.saveUserData()
//                }
//                if phase == .active {
//                    //print("scenePhase")
//                    //self.timeManager.saveTimeCalendarData(title: "start_timer")
//                }
//            }
//        }
    }
    
    var characterImageViewAndCircle: some View {
        ZStack {
            // ポイントを自動で育成に当てている場合に表示
            if self.timeManager.selectedUsePointMode != 0 {
                Circle()
                    .trim(from: 0.01, to: returnGrowCircleRatio() - 0.01)
                    .stroke(Color.blue.opacity(0.5), style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                    .scaledToFit()
                    .rotationEffect(Angle(degrees: -90))
                Circle()
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                    .scaledToFit()
                    .opacity(0.1)
            }
            Image(self.timeManager.selectedCharacterImageName)
                .resizable()
                //.shadow(color: .black.opacity(0.3), radius: 5)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 30)
                .padding(30)
                .onTapGesture {
                    // キャラクター詳細画面を表示
                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                    impactLight.impactOccurred()
                    self.timeManager.loadCharacterDetailData(selectedDetailCharacter: self.timeManager.selectedCharacter)
                    
                    showCharacterDetailView.toggle()
                }
            
        }
        .frame(width: returnImageSize(), height: returnImageSize())
    }
    
    var taskNameView: some View {
        Text("\(self.timeManager.task)")
            .font(.system(size: titleFontSize))
            .foregroundColor(Color(UIColor.systemGray4))
    }
    
    var timerView: some View {
        VStack(spacing: 0) {
            if self.timeManager.autoRefreshFlag {
                //Text(self.timeManager.displayTimer())
                Text(self.timerString)
                    .font(Font(UIFont.monospacedDigitSystemFont(ofSize: timerFontSize, weight: .medium)))
                    .onReceive(self.timeManager.timer, perform: { _ in
                        self.timerString = self.timeManager.displayTimer()
                               })
                
                if !self.timeManager.notShowTotalTimeFlag {
                    //Text("Total. \(self.timeManager.runtimeToString(time: self.timeManager.runtime, second: true, japanease: false, onlyMin: false))")
                    Text("Total. \(self.totalTimerString)")
                        .font(Font(UIFont.monospacedDigitSystemFont(ofSize: totalTimeFontSize, weight: .regular)))
                        .foregroundColor(Color(UIColor.systemGray4))
                        .onReceive(self.timeManager.timer, perform: { _ in
                            self.totalTimerString = self.timeManager.runtimeToString(time: self.timeManager.runtime, second: true, japanease: false, onlyMin: false)
                                   })
                }
                
            } else {
                Text("\(self.timeManager.updatedTimer)")
                    .font(Font(UIFont.monospacedDigitSystemFont(ofSize: timerFontSize, weight: .medium)))
                
                if !self.timeManager.notShowTotalTimeFlag {
                    Text("Total. \(self.timeManager.updatedTotalTimer)")
                        .font(Font(UIFont.monospacedDigitSystemFont(ofSize: totalTimeFontSize, weight: .regular)))
                        .foregroundColor(Color(UIColor.systemGray4))
                }
            }
        }
    }
    
    private func viewTappedAction() {
        if !self.timeManager.autoRefreshFlag {
            // バイブレーション
            let impactLight = UIImpactFeedbackGenerator(style: .light)
            impactLight.impactOccurred()
            
            // 画面をタップするとカウントダウンタイマーのUIを更新する
            self.timeManager.updateTimer()
        }
    }
    
    private func returnImageSize() -> CGFloat {
        var imageSize: CGFloat = 0
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        
        let minLength: CGFloat = min(screenHeight, screenWidth)
        imageSize = minLength * 0.7

        return imageSize
    }
        
    // キャラクター育成状態の円グラフを表示
    private func returnGrowCircleRatio() -> Double{
        let hp = self.timeManager.selectedCharacterHP
        let expRatio = self.timeManager.selectedCharacterExpRatio
        let phaseCount = self.timeManager.selectedCharacterPhaseCount
        var thisPhaseHP = 0.0
        var nowExp = 0.0
        
        if phaseCount == 0 {
            thisPhaseHP = hp * expRatio[phaseCount]
            nowExp = self.timeManager.expTime
        } else if phaseCount == expRatio.count {
            thisPhaseHP = hp - hp * expRatio[phaseCount-1]
            nowExp = self.timeManager.expTime - hp * expRatio[phaseCount-1]
        } else {
            thisPhaseHP = hp * expRatio[phaseCount] - hp * expRatio[phaseCount-1]
            nowExp = self.timeManager.expTime - hp * expRatio[phaseCount-1]
        }
        
        let ratio = nowExp / thisPhaseHP
        //print("returnGrowRatio(): \n\(hp) \(expRatio) \(phaseCount) \(thisPhaseHP) \(nowExp) \(ratio)")
        return ratio
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
            .environmentObject(TimeManager())
    }
}
